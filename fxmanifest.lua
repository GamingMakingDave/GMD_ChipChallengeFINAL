fx_version 'cerulean'
games { 'gta5' }

author 'GMD_Scripts & Sander'
description 'chipchallange script'
version '1.0'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_food_one_nacho_a.ytyp'

lua54 'yes'

shared_script '@es_extended/imports.lua'

shared_scripts {
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

server_script {
	'server/*.lua'
}

dependencies {
	'es_extended',
    'esx_status'
}