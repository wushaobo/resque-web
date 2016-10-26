%w(resque_web.gemspec
lib/
app/
Rakefile
.env
.ruby-version
PLUGINS.md
README.md
HISTORY.md
test/
config/
.travis.yml
coverage/
.idea/
.bundle/
Gemfile
Gemfile.lock
pkg/
docker/
.dockerignore
Dockerfile).each do |file|
	`rm -rf #{file}`
end

`git checkout .`