try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'Red October',
    'author': 'Holly Gibson',
    'url': 'www.github.com',
    'download_url': 'Github',
    'author_email': 'wha7ev3r@gmail.com',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['red_october'],
    'scripts': [],
    'name': 'Red October'
}

setup(**config)