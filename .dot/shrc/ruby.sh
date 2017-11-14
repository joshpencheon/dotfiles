# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# jRuby:
export JRUBY_OPTS="--server -J-Xms1500m -J-Xmx1500m -J-XX:+UseConcMarkSweepGC -J-XX:-UseGCOverheadLimit -J-XX:+CMSClassUnloadingEnabled"

