# Windmill

Simple development environment for Laravel with podman

## Dependencies	

For fedora:

```bashscript
# dnf install podman slirp4netns
```

## Configuration

Verify that your user exists in the files `/etc/subuid` and `/etc/subgid`.

```bashscript
$ grep johndoe /etc/subuid /etc/subgid
/etc/subuid:johndoe:100000:65536
/etc/subgid:johndoe:100000:65536
```

If your user does not appear in these files you can add it with the following command:

```bashscript
# usermod --add-subuids 100000-165535 --add-subgids 100000-165535 johndoe 
$ grep johndoe /etc/subuid /etc/subgid
/etc/subuid:johndoe:100000:65536
/etc/subgid:johndoe:100000:65536
```

Add capabilities to shadow-util to write setuid programs (or setfilecap). For Fedora:

```bashscript
$ getcap /usr/bin/newuidmap
/usr/bin/newuidmap = cap_setuid+ep
```

## Get up Pod

### Clone repo

```bashscript
git clone https://github.com/searchsam/windmill.git
```

### Add laravel project

Go into windmill folder and add the path of the laravel project into `laravel.yaml` file on the `volumes` section.

```yaml
- hostPath:
      path: /path/to/project
      type: Directory
```

### Build Pod

```bashscript
$ podman play kube larapod.yaml
```

Now Pod is running.

## Extra

For better control of containers you can install Podman Desktop from here https://podman-desktop.io/downloads.