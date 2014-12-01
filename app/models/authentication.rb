class Authentication < ActiveRecord::Base
  belongs_to :user

end



# you visit the auth callback page
# it checks if you're logged in
# if you are, it tries to find auth
# if auth exists, tells you that auth is already associate with another user
# if not, it creates that auth and adds it to this bro

# if not logged in, tries to find auth, if found returns user, if not creates user
