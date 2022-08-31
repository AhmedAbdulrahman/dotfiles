# ---------------------------------------------
# Direnv
# ---------------------------------------------
if [ $(command -v direnv) ]; then
   export NODE_VERSIONS="${HOME}/.node-versions"
   export NODE_VERSION_PREFIX=""
   eval "$(direnv hook zsh)"
fi