name        'db'
description 'MySQL database server'
run_list    'recipe[hostname]',
            'recipe[mysql::server]'
