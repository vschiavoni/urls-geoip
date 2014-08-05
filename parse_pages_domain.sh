#/bin/bash
#luajit parse_pages_domain.lua
./gen_cdf.rb -f pages_domain_all_count.txt -c 2 > data/cdf_pages_domain_all.txt
./gen_cdf.rb -f pages_domain_valid_count.txt -c 2 > data/cdf_pages_domain_valid.txt
./gen_cdf.rb -f pages_domain_invalid_count.txt -c 2 > data/cdf_pages_domain_invalid.txt
