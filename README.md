# Windmill

Simple development environment for Laravel with podman

## Dependencies	

For fedora:

```bash
dnf install podman slirp4netns
```

## Configuration

Verify that your user exists in the files `/etc/subuid` and `/etc/subgid`.

```bash
grep johndoe /etc/subuid /etc/subgid
/etc/subuid:johndoe:100000:65536
/etc/subgid:johndoe:100000:65536
```

If your user does not appear in these files you can add it with the following command:

```bash
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 johndoe 

grep johndoe /etc/subuid /etc/subgid
/etc/subuid:johndoe:100000:65536
/etc/subgid:johndoe:100000:65536
```

Add capabilities to shadow-util to write setuid programs (or setfilecap). For Fedora:

```bash
getcap /usr/bin/newuidmap
/usr/bin/newuidmap = cap_setuid+ep
```

## Get up Pod

### Clone repo

```bash
git clone https://github.com/searchsam/windmill.git
```

### Add laravel project

Go into windmill folder and add the path of the laravel project in the volumes section called `code-data` of the `larapod.yaml` file.

```yaml
volumes:
  ...
  - name: code-data
    hostPath:
      path: ~/projects/project
      type: Directory
```

### Persist the database

Create a folder called `mysql` in your laravel project directory and add the path to the mysql directory in the volumes section called `db-data` of the `larapod.yaml` file.

```yaml
volumes:
  ...
  - name: db-data
    hostPath:
      path: ~/projects/project
      type: Directory
```

### Build Pod

```bash
podman play kube larapod.yaml
```

Now Pod is running.

## Extra

For better control of containers you can install [Podman Desktop](https://podman-desktop.io/downloads).