function reademl
    awk 'BEGIN {var=9999;} {if ($2=="base64") {var=NR+1} else if (NR!=var && $0=="") {var=9999}; if (NR>var) print $0;}' $argv[1] | base64 -d
end
