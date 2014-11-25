docker-example
==============

This will create an example LAMP stack showing php querying and updating mysql database container


### 1. Installation/Setup

This section will install the necessary dependencies for docker to operate

```bash
apt-get install -y git
git clone https://github.com/f2s/docker-example.git
cd docker-example
./1_setup.sh
```

### 2. Build images

This will iterate through the build.txt file and tag successful images

```bash
./2_build.sh
```

### 3. Run images

Creates runtime containers based on images previously created

```bash
./3_run.sh
```

### 4. View results

Browse http://localhost:5000 to see results

```
curl http://localhost:5000
```