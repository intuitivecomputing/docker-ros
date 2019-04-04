from fabric.api import local
from fabric.decorators import task
from os.path import dirname, realpath, join
from functools import wraps

project_suffix = 'ros-'

# def name_assertion(func):
#     @wraps(func)
#     def function_wrapper(*args, **kwargs):
#         try:
#             assert not ('docker-' in project_name or 'ros-' in project_name)
#             func(*args, **kwargs)
#         except AssertionError:
#             print("Project name should be stripped of 'docker-ros' suffix")
#         return func(*args, **kwargs)
#     return function_wrapper

def name_auto_fix(func):
    @wraps(func)
    def function_wrapper(*args, **kwargs):
        args_copy = list(args)
        project_name = args_copy[0]
        if 'docker-' in project_name:
            project_name = project_name[len('docker-'):]
        if 'ros-' in project_name:
            project_name = project_name[len('ros-'):]
        print("Project name should be stripped of 'docker-ros' suffix.")
        print("Auto fix result: {}".format(project_name))
        args_copy[0] = project_name
        # print('args:', args_copy, kwargs)
        return func(*args_copy, **kwargs)
    return function_wrapper

@task
@name_auto_fix
def docker_exec(project_name, cmdline='/bin/bash'):
    """
    Execute command in running docker container
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix
    :param cmdline: command to be executed
    """
    local('docker exec -ti ros-{} {}'.format(project_name, cmdline))


@task
@name_auto_fix
def docker_build(project_name, options=''):
    """
    Build docker image
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix
    :param options: other optionss
    """

    docker_stop(project_name)
    local('docker build {options} -t yuxianggao/ros-{project_name}:$(dpkg --print-architecture) ./dockers/ros-{project_name}'.format(options=options, project_name=project_name))


@task
@name_auto_fix
def docker_start(project_name, map_repos=False, detach=False, cmd=False):
    """
    Start docker container
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix
    :param map_repos: wether mount ./package to catkin_ws/src
    """

    docker_stop(project_name)
    detach = '-d' if detach else ''
    # volume_arg = ''
    # if map_repos:
    #     for repos in map_repos
    #         volume_arg += '-v {dir}/packages/{volume_name}:$HOME/catkin_ws/src/{volume_name} '.format(dir=join(dirname(realpath(__file__))), volume_name=repos)
    # map_repos = volume_arg if map_repos else ''
    map_repos = '-v {dir}/packages:$HOME/catkin_ws/src'.format(dir=join(dirname(realpath(__file__))), volume_name=map_repos) if map_repos else ''
    cmd = '/bin/bash -c "{}"'.format(cmd) if cmd else "/bin/bash"
    local('xhost +local:root')
    local('docker run -it --rm \
                    -e DISPLAY=$DISPLAY \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v $HOME/.Xauthority:$HOME/.Xauthority \
                    {map_repos} \
                    --net=host \
                    --privileged \
                    --name ros-{project_name} {detach} \
                    --volume /dev:/dev \
                    -t yuxianggao/ros-{project_name}:$(dpkg --print-architecture) \
                    {cmd}'.format(project_name=project_name,
                                                map_repos=map_repos,
                                                detach=detach,
                                                cmd=cmd))


@task
@name_auto_fix
def docker_stop(project_name):
    """
    Stop docker container
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix
    """
    local('docker kill ros-{} || true'.format(project_name))

@task
@name_auto_fix
def docker_remove(project_name):
    """
    Remove docker container
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix:param project_name: project to build. Should be stripped of 'docker-ros' suffix
    """
    local('docker rm ros-{}'.format(project_name))


@task
def docker_sh():
    """
    Execute command in docker container
    """
    docker_exec('/bin/bash')


@task
def docker_logs(project_name):
    """
    Print stdout/stderr from container entrypoint
    :param project_name: project to build. Should be stripped of 'docker-ros' suffix
    :return::param project_name: project to build. Should be stripped of 'docker-ros' suffix
    """
    local('docker logs ros-{} -f'.format(project_name))


@task
def test(params=''):
    """
    Run all tests in docker container
    :param params: parameters to py.test
    """
    docker_exec('py.test {}'.format(params))


@task
def test_sx(params=''):
    """
    Execute all tests in docker container printing output and terminating tests at first failure
    :param params: parameters to py.test
    """
    docker_exec('py.test -sx {}'.format(params))


@task
def test_pep8():
    """
    Execute  only pep8 test in docker container
    """
    docker_exec('py.test tests/test_pep8.py')


@task
def fix_pep8():
    """
    Fix a few common and easy PEP8 mistakes in docker container
    """
    docker_exec('autopep8 --select E251,E303,W293,W291,W391,W292,W391,E302 --aggressive --in-place --recursive .')
