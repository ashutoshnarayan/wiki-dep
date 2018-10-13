default["lamp"]["sites"]["mediawiki.com"] = {"port" => 80, "servername" => "mediawiki.com", "serveradmin" => "webmaster@mediawiki.com" }

default["lamp"]["mediawiki"]["version"] = "1.31.1"
default["lamp"]["mediawiki"]["tarball"]["name"] = "mediawiki-" + default["lamp"]["mediawiki"]["version"] + ".tar.gz"
default["lamp"]["mediawiki"]["tarball"]["url"] = "https://releases.wikimedia.org/mediawiki/1.31/" + default["lamp"]["mediawiki"]["tarball"]["name"]

default["lamp"]["mediawiki"]["app"] = "mediawiki"
