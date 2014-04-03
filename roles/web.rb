name        'web'
description 'A simple web server'
run_list    'recipe[hostname]',
            'recipe[apache2]',
            'recipe[mysql::client]'
