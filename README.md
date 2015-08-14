# Social Security Deaths Database

- The data is gathered from http://cancelthesefunerals.com/
- `app` is a dir with a tiny stub flask app for hosting dead people

# Converting the deaths to sqlite3

Expect the current directory to grow to ~22GB.

````bash
$ make
````

This will:
1. Download the (very large) data files from http://cancelthesefunerals.com/ into the data dir
1. Create a `deaths.db` sqlite database
1. Convert the data (takes a while)
1. Import the deaths into `deaths.db`
1. Run indexes and virtual table stuff
