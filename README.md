# authorized_users
This repo stores names of github users which are allowed to login into csi servers

The repo follows a simple directory structure. Each folder on the root level represents a server (for example csivit)
Inside a server's folder, each file of filename <name> stores the usernames of github users allowed to access the 
user with username <name> on the server.

# Why?
OpenSSH keys are normally listed in the `~/.ssh/authorized_keys` file, but this is terrible to manage, as you have to deal
with issues like removing old keys, and its really difficult to read this file. What ends up happening is a big blob of random
keys in a file added by completely random people. And then if you have multiple servers, the issue just becomes worse.

# How does this repo work?
This repo is inspired by https://gist.github.com/sivel/c68f601137ef9063efd7 .
In brief, it takes advantage of the `AuthorizedKeysCommand` configuration option that can be provided to OpenSSH.

Let's say a user tries to login on root@csivit.com. The sshd daemon on the server will first try to search if the user is given access
through `/root/.ssh/authorized_keys`. If not, it will execute the get_keys.sh script.

This script obtains the github usernames of permitted users from the `csivit/root` file on this repo, and then obtain github public 
keys for every user in that file by obtaining them from `https://github.com/<username>.keys`. It finally tells OpenSSH to allow just these
public keys to login!

# Great! How do I use it?
Install the get_keys.sh script on /usr/local/bin on the server, and make it executable
```
cd /usr/local/bin
wget -O get_keys https://raw.githubusercontent.com/csivitu/authorized_users/master/get_keys.sh
chmod +x get_keys
```

Add the following lines in /etc/ssh/sshd_config , where `server_name` is same as the folder name for that server on this repo.
```
AuthorizedKeysCommand /usr/local/bin/get_keys  https://raw.githubusercontent.com/csivitu/authorized_users/master <server_name> %u
AuthorizedKeysCommandUser nobody
```

Now if you want to give access, to say github user `thebongy` to  root on the server, just make a file at `server_name/root`, and add
`thebongy` inside the file. That's it!

