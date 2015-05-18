try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'My Project',
    'author': 'Holly Gibson',
    'url': 'www.github.com',
    'download_url': 'Github',
    'author_email': 'wha7ev3r@gmail.com',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['NAME'],
    'scripts': [],
    'name': 'skeleton'
}

setup(**config)