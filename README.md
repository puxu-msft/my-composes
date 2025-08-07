# my-composes

Enjoy composing!

## FAQ

### Set compose project name

In compose.yml:

```yaml
name: my-custom-stack
```

Command-line args:

```bash
podman-compose --project-name my-custom-stack up -d
# or
podman-compose -p my-custom-stack up -d
# or
export COMPOSE_PROJECT_NAME=my-custom-stack
podman-compose up -d
```
