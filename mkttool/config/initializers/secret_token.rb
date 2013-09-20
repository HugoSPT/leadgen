# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Mkttool::Application.config.secret_key_base = '5b1586095abf2ac7584c45baca735f40d952bad432463072316065332c1224a675e56202c9884d6b8414566a171cf7ea4e2b661a5970d549ee6a3087b40012c2'
Mkttool::Application.config.secret_token = 'a08273aaebfa50767e9e607e6ed14f18b636b996c5a6e21fb082ca44fd6f5095bafea4a7a267aa413e985e86d596d488eb09ceec6482bca8e7c504874bf49a09'