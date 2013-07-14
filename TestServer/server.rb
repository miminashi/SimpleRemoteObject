# -*- coding: UTF-8 -*-

require 'webrick'
require 'json'

include WEBrick
port = 2000;

puts "Starting server: http://#{Socket.gethostname}:#{port}"
docroot = File::dirname($0)
server = HTTPServer.new(:Port=>port,:DocumentRoot=>docroot )

# prepares BASIC Auth
realm = "Hello, oquno"
htpd = HTTPAuth::Htpasswd.new('dot.htpasswd')
htpd.set_passwd(nil, 'oquno', 'dankogai')
$authenticator = HTTPAuth::BasicAuth.new(:UserDB => htpd, :Realm => realm)

server.mount_proc("/") { |req, res|
  path = File.join(docroot,*req.path.split("/"))

  res.body = File.open(path){|file|
    file.binmode # バイナリモードでのオープン
    file.read
  }

  # 拡張子とContent-Typeの対応表
  content_types = {
    ".html" => "text/html", ".txt" => "text/plain",
    ".json" => "application/json; charset=UTF-8"
  }
  # filenameの拡張子を見てContent-Typeを設定
  content_type = content_types[File.extname(path)]
  # Content-Typeが見つからなかったらtext/htmlを設定
  if content_type==nil
    content_type = "text/html"
  end
  res["Content-Type"] = content_type
}

# REST GET
server.mount_proc("/tags/1.json") { |req, res|
  path = File.join(docroot, 'tag_1.json')
  res.body = File.open(path){|file|
    file.binmode # バイナリモードでのオープン
    file.read
  }
  res["Content-Type"] = "application/json; charset=UTF-8"
}

server.mount_proc("/private_tags.json") { |req, res|
  $authenticator.authenticate(req, res)
  path = File.join(docroot, 'private_tags.json')
  res.body = File.open(path){|file|
    file.binmode
    file.read
  }
  res["Content-Type"] = "application/json; charset=UTF-8"
}

server.mount_proc("/longtime") { |req, res|
  res.body = '{"result":"ok"}'
  sleep(5)
  res["Content-Type"] = "application/json; charset=UTF8"
}

server.mount_proc("/echo") { |req, res|
  res.body = JSON.generate(req.query)
  res["Content-Type"] = "application/json; charset=UTF8"
}

class PostServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(req, res)
    res.body = JSON.generate(req.query)
    res["Content-Type"] = "application/json; charset=UTF8"
  end
end
server.mount("/post", PostServlet)

class BasicAuthPostServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(req, res)
    $authenticator.authenticate(req, res)
    res.body = JSON.generate(req.query)
    res["Content-Type"] = "application/json; charset=UTF8"
  end
end
server.mount("/private/post", BasicAuthPostServlet)


trap("INT"){ server.shutdown }
server.start

