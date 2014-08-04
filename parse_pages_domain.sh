#/bin/bash
luajit parse_pages_domain.lua > pages_domain_raw.txt
./gen_cdf.rb -f pages_domain_raw.txt -c 2 > data/cdf_pages_domain.txt
