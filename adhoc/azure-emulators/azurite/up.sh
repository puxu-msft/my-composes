#!/usr/bin/env bash
# ver: 250825

# -e : exit immediately if a command exits with a non-zero status
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [[ $# -lt 1 ]]; then
    set -- -h
fi

if [[ $# -gt 1 && $1 =~ ^(up|down|start|stop|restart)$ ]]; then
    # --remove-orphans : remove containers for services not defined in the Compose file
    set -- "$@" --remove-orphans
fi

pushd "$(dirname "$0")" || exit 1
echo -e "${YELLOW}📂 Entered $(pwd)${NC}"

# if [[ $# -gt 1 && $1 =~ ^(up)$ ]]; then
#     docker compose pull
# fi

echo -e "${YELLOW}🔨 docker compose $@${NC}"
# -f : specify the compose file, default is docker-compose.yml
docker compose "$@"

popd
