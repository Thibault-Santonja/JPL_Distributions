"""from jupyter_core.paths import jupyter_data_dir
import subprocess
import os
import errno
import stat"""

c = get_config()  # noqa: F821
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False



