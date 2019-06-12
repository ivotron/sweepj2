from setuptools import setup

# version = {}
# with open('popper/__init__.py') as f:
#     exec(f.read(), version)

setup(
    name='sweepj2',
    version='1.0',
    author='The Popper Development Team',
    author_email='ivo@cs.ucsc.edu',
    url='http://falsifiable.us',
    description='Utilities for running parameter sweeps by providing a Jinja2 template and a parameter space (in YAML).',
    packages=['sweepj2'],
    include_package_data=True,
    install_requires=[
        'Jinja2',
        'pyyaml'
    ],
    entry_points='''
        [console_scripts]
        popper=popper.cli:cli
    ''',
    keywords='parameter sweep, grid search',
    license='MIT',
)