# where-are-we
Schedule table (Koudou-Yotei Hyou) for me based on Caveman2 ( https://github.com/fukamachi/caveman )
合宿的なもので週末にさっと書いてちょっと使われただけのものから、固有名と緯度経度を抜いて公開


## Requirements
Common Lisp (Checked only on sbcl)  
shly  ( http://shlyfile.org/ )  
QuickLisp  ( https://www.quicklisp.org/beta/ )  
If not using Hunchentoot, FastCGI

## Usage
Add users in src/config.lisp. 
Change salt in same file. 

(where-are-we.util::list-checkin-url) will show all the users' checkin URL.

To run the webapp, run
'''
$ APP_ENV={development|production} shly start
'''

## Installation
None.

## Author

* Naoaki Iwakiri <naokiri@gmail.com>
* Osamu Koga <osa_k@gmail.com>

## Copyright

Copyright (c) 2015 Naoaki Iwakiri

