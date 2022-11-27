# bash-utils
Various bash util scripts

### Python Utils 

#### Activate Python venv and run Python script

```bash
$> chmod +x python/activate_venv_and_run_python.sh
$> python/activate_venv_and_run_python.sh ${SERVICE_NAME} ${METHOD_NAME} [parameters...]
```

#### Run Python scripts using Docker

```bash
$> chmod +x python/run_docker.sh
$> python/run_docker.sh ${SERVICE_NAME} ${METHOD_NAME} [parameters...]
```

#### Run Python tests using Docker Compose

```bash
$> chmod +x python/run_tests_using_docker_compose.sh
$> python/run_tests_using_docker_compose.sh
```