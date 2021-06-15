#!/bin/bash

################################################################################
## @author      : Arno Lievens (arnolievens@gmail.com)                        ##
## @file        : parcel-setup.sh                                             ##
## @created     : Wednesday Jun 08                                            ##
##                                                                            ##
## @description : clone starter-kit repository and optionally set new remote  ##
################################################################################


#######
# the url of the starterkit repository
#
starterkit_url="https://github.com/verhulstd/parcel2starterkit.git"


#######
# global vars
#
repo_path=""
repo_url=""
repo_name=""
matrix=false
nsfw=false


#######
# name of this script
#
pgm="$(basename "$0")"


################################################################################
##                                 functions                                  ##
################################################################################

#######
# obfuscated b(.)(.)bs
#
nsfw_mode()
{
    echo \
'
ICAgICAgICAgICAgICAgICAgICAgICAgIDg4ODggIDg4ODg4ODgKICAgICAgICAgICAgICAgICAg
ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4CiAgICAgICAgICAgICAgIDg4ODg6Ojo4ODg4ODg4ODg4
ODg4ODg4ODg4ODg4ODg4CiAgICAgICAgICAgICA4ODg4Ojo6Ojo6ODg4ODg4ODg4ODg4ODg4ODg4
ODg4ODg4ODg4OAogICAgICAgICAgICA4ODo6Ojo6Ojo6ODg4Ojo6ODg4ODg4ODg4ODg4ODg4ODg4
ODg4ODg4OAogICAgICAgICAgODg4ODg4ODg6Ojo6ODo6Ojo6Ojo6Ojo6ODg4ODg4ODg4ODg4ODg4
ODg4ODgKICAgICAgICA4ODggODo6ODg4ODg4Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6ODg4ODg4ODg4ODgg
ICA4ODgKICAgICAgICAgICA4ODo6Ojo4ODg4ODg4ODo6OjptOjo6Ojo6Ojo6Ojg4ODg4ODg4ODg4
ICAgIDgKICAgICAgICAgODg4ODg4ODg4ODg4ODg4ODg4Ok06Ojo6Ojo6Ojo6Ojg4ODg4ODg4ODg4
ODgKICAgICAgICA4ODg4ODg4ODg4ODg4ODg4ODg4ODo6Ojo6Ojo6Ojo6Ok04ODg4ODg4ODg4ODg4
OAogICAgICAgIDg4ODg4ODg4ODg4ODg4ODg4ODg4ODg6Ojo6Ojo6OjpNODg4ODg4ODg4ODg4ODg4
OAogICAgICAgICA4ODg4ODg4ODg4ODg4ODg4ODg4ODg4Ojo6Ojo6Ok04ODg4ODg4ODg4ODg4ODg4
ODgKICAgICAgICA4ODg4ODg4ODg4ODg4ODg4Ojo4ODg4ODo6Ojo6Ok04ODg4ODg4ODg4ODg4ODg4
ODg4OAogICAgICA4ODg4ODg4ODg4ODg4ODg4ODo6Ojg4ODg4Ojo6OjpNODg4ODg4ODg4ODg4ODg4
ICAgODg4OAogICAgIDg4ODg4ODg4ODg4ODg4ODg4Ojo6ODg4ODg6Ojo6TTo6O28qTSpvOzg4ODg4
ODg4OCAgICA4OAogICAgODg4ODg4ODg4ODg4ODg4ODg6Ojo4ODg4Ojo6OjpNOjo6Ojo6Ojo6Ojo4
ODg4ODg4OCAgICA4CiAgIDg4ODg4ODg4ODg4ODg4ODg4Ojo6Ojg4Ojo6Ojo6TTo7Ojo6Ojo6Ojo6
Ojo4ODg4ODg4ODgKICA4ODg4ODg4ODg4ODg4ODg4ODg4Ojo6ODo6Ojo6Ok06OmFBYTo6Ojo6Ojo6
TTg4ODg4ODg4ODggICAgICAgOAogIDg4ICAgODg4ODg4ODg4ODo6ODg6Ojo6ODo6OjpNOjo6Ojo6
Ojo6Ojo6Ojg4ODg4ODg4ODg4ODg4OCA4ODg4CiA4OCAgODg4ODg4ODg4ODg6Ojo4Ojo6Ojo6Ojo6
TTo6Ojo6Ojo6Ojo7Ojo4ODo4ODg4ODg4ODg4ODg4ODg4OAogOCAgODg4ODg4ODg4ODg4ODo6Ojo6
Ojo6Ojo6TTo6IkBAQEBAQEAiOjo6Ojh3ODg4ODg4ODg4ODg4ODg4OAogIDg4ODg4ODg4ODg4Ojg4
ODo6Ojo6Ojo6OjpNOjo6OjoiQGFAIjo6Ojo6TThpODg4ODg4ODg4ODg4ODg4CiA4ODg4ODg4ODg4
Ojo6Ojg4Ojo6Ojo6Ojo6TTg4Ojo6Ojo6Ojo6Ojo6Ok04OHo4ODg4ODg4ODg4ODg4ODg4OAo4ODg4
ODg4ODg4Ojo6Ojo4Ojo6Ojo6Ojo6TTg4ODg4Ojo6Ojo6Ojo6TU04ODghODg4ODg4ODg4ODg4ODg4
ODg4Cjg4ODg4ODg4ODo6Ojo6ODo6Ojo6Ojo6Ok04ODg4ODg4TUFtbW1BTVZNTTg4OCo4ODg4ODg4
OCAgIDg4ODg4ODg4Cjg4ODg4OCBNOjo6Ojo6Ojo6Ojo6Ojo6TTg4ODg4ODg4ODo6Ojo6OjpNTTg4
ODg4ODg4ODg4ODg4ICAgODg4ODg4OAo4ODg4ICAgTTo6Ojo6Ojo6Ojo6Ojo6TTg4ODg4ODg4ODg4
Ojo6Ojo6TU04ODg4ODg4ODg4ODg4ODggICAgODg4ODgKIDg4OCAgIE06Ojo6Ojo6Ojo6Ojo6TTg4
ODg4ODg4ODg4ODhNOjo6OjptTTg4ODg4ODg4ODg4ODg4OCAgICA4ODg4CiAgODg4ICBNOjo6Ojo6
Ojo6Ojo6TTg4ODg6ODg4ODg4ODg4ODg4Ojo6Om06Ok1tODg4ODggODg4ODg4ICAgODg4OAogICA4
OCAgTTo6Ojo6Ojo6Ojo6Ojg4ODg6ODg4ODg4ODg4ODg4ODg4ODg6Ojo6OjpNbTggICA4ODg4OCAg
IDg4OAogICA4OCAgTTo6Ojo6Ojo6Ojo4ODg4TTo6ODg4ODg6Ojg4ODg4ODg4ODg4ODo6Ojo6OjpN
bTg4ODg4ICAgIDg4CiAgIDggICBNTTo6Ojo6Ojo6ODg4OE06Ojo4ODg4Ojo6Ojo4ODg4ODg4ODg4
ODg6Ojo6Ojo6Ok1tOCAgICAgNAogICAgICAgOE06Ojo6Ojo6ODg4OE06Ojo6Ojg4ODo6Ojo6Ojo4
ODo6Ojg4ODg4ODg6Ojo6Ojo6Ok1tICAgIDIKICAgICAgODhNTTo6Ojo6ODg4OE06Ojo6Ojo6ODg6
Ojo6Ojo6Ojg6Ojo6Ojg4ODg4ODo6Ok06Ojo6Ok0KICAgICA4ODg4TTo6Ojo6ODg4TU06Ojo6Ojo6
Ojg6Ojo6Ojo6Ojo6Ok06Ojo6ODg4ODo6OjpNOjo6Ok0KICAgIDg4ODg4TTo6Ojo6ODg6TTo6Ojo6
Ojo6Ojo4Ojo6Ojo6Ojo6OjpNOjo6ODg4ODo6Ojo6Ok06Ok0KICAgODggODg4TU06Ojo4ODg6TTo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TTo4ODg4Ojo6Ojo6Ojo6TToKICAgOCA4ODg4OE06Ojo4ODo6
TTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU06ODg6Ojo6Ojo6Ojo6OjpNCiAgICAgODg4ODhNOjo6
ODg6Ok06Ojo6Ojo6Ojo6Kjg4Kjo6Ojo6Ojo6OjpNOjg4Ojo6Ojo6Ojo6Ojo6OjpNCiAgICA4ODg4
ODhNOjo6ODg6Ok06Ojo6Ojo6Ojo4OEBAODg6Ojo6Ojo6OjpNOjo4ODo6Ojo6Ojo6Ojo6Ojo6TQog
ICAgODg4ODg4TU06Ojg4OjpNTTo6Ojo6Ojo6ODhAQDg4Ojo6Ojo6Ojo6TTo6Ojg6Ojo6Ojo6Ojo6
Ojo6Oio4CiAgICA4ODg4OCAgTTo6Ojg6Ok1NOjo6Ojo6Ojo6Kjg4Kjo6Ojo6Ojo6OjpNOjo6Ojo6
Ojo6Ojo6Ojo6Ojo4OEBACiAgICA4ODg4ICAgTU06Ojo6OjpNTTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6
Ok1NOjo6Ojo6Ojo6Ojo6Ojo6Ojo4OEBACiAgICAgODg4ICAgIE06Ojo6Ojo6TU06Ojo6Ojo6Ojo6
Ojo6Ojo6Ojo6TU06Ok06Ojo6Ojo6Ojo6Ojo6Ojo6KjgKICAgICA4ODggICAgTU06Ojo6Ojo6TU1N
Ojo6Ojo6Ojo6Ojo6Ojo6Ok1NOjo6TU06Ojo6Ojo6Ojo6Ojo6OjpNCiAgICAgIDg4ICAgICBNOjo6
Ojo6OjpNTU1NOjo6Ojo6Ojo6OjpNTU1NOjo6OjpNTTo6Ojo6Ojo6Ojo6Ok1NCiAgICAgICA4OCAg
ICBNTTo6Ojo6Ojo6Ok1NTU1NTU1NTU1NTU1NTTo6Ojo6Ojo6TU1NOjo6Ojo6OjpNTU0KICAgICAg
ICA4OCAgICBNTTo6Ojo6Ojo6Ojo6Ok1NTU1NTU06Ojo6Ojo6Ojo6Ojo6Ok1NTU1NTU1NTU0KICAg
ICAgICAgODggICA4TU06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NTU1NCiAg
ICAgICAgICA4ICAgODhNTTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNOjo6TTo6Ojo6Ojo6TU0KICAg
ICAgICAgICAgICA4ODhNTTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok1NOjo6Ojo6TU06Ojo6OjpNTQogICAg
ICAgICAgICAgODg4ODhNTTo6Ojo6Ojo6Ojo6Ojo6Ok1NTTo6Ojo6OjptTTo6Ojo6TU0KICAgICAg
ICAgICAgIDg4ODg4OE1NOjo6Ojo6Ojo6Ojo6Ok1NTTo6Ojo6Ojo6Ok1NTTo6Ok0KICAgICAgICAg
ICAgODg4ODg4ODhNTTo6Ojo6Ojo6Ojo6TU1NOjo6Ojo6Ojo6OjpNTTo6Ok0KICAgICAgICAgICA4
OCA4ODg4ODg4TTo6Ojo6Ojo6Ok1NTTo6Ojo6Ojo6Ojo6Ojo6TTo6Ok0KICAgICAgICAgICA4ICA4
ODg4ODggTTo6Ojo6OjpNTTo6Ojo6Ojo6Ojo6Ojo6Ojo6TTo6Ok06CiAgICAgICAgICAgICAgODg4
ODg4IE06Ojo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok06OjpNTQogICAgICAgICAgICAgODg4ODg4
ICBNOjo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TTpNCiAgICAgICAgICAgICA4ODg4ODgg
IE06Ojo6Ok06Ojo6Ojo6OjpAOjo6Ojo6Ojo6Ojo6OjpNOjpNCiAgICAgICAgICAgICA4ODg4OCAg
IE06Ojo6Ojo6Ojo6Ojo6OkBAOjo6Ojo6Ojo6Ojo6Ojo6TTo6TQogICAgICAgICAgICA4ODg4OCAg
IE06Ojo6Ojo6Ojo6Ojo6OkBAQDo6Ojo6Ojo6Ojo6Ojo6OjpNOjpNCiAgICAgICAgICAgODg4ODgg
ICBNOjo6Ojo6Ojo6Ojo6Ojo6QEA6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNOjpNCiAgICAgICAgICA4ODg4
OCAgIE06Ojo6Om06Ojo6Ojo6Ojo6QDo6Ojo6Ojo6OjpNbTo6Ojo6OjpNOjo6TQogICAgICAgICAg
ODg4OCAgIE06Ojo6Ok06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok1NOjo6Ojo6Ok06OjpNCiAgICAg
ICAgIDg4ODggICBNOjo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU06Ojo6Ojo6Ok06OjpN
CiAgICAgICAgODg4ICAgIE06Ojo6Ok1tOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok1NTTo6Ojo6Ojo6
Ok06Ojo6TQogICAgICA4ODg4ICAgIE1NOjo6Ok1tOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NTTo6
Ojo6Ojo6Om06Om06OjpNCiAgICAgODg4ICAgICAgTTo6Ojo6TTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6
TU1NOjo6Ojo6Ojo6Ojo6TTo6bW06OjpNCiAgODg4OCAgICAgICBNTTo6Ojo6Ojo6Ojo6Ojo6Ojo6
Ojo6Ojo6OjpNTTo6Ojo6Ojo6Ojo6OjptTTo6TU06OjpNOgogICAgICAgICAgICAgTTo6Ojo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6bU06Ok1NOjo6TW0KICAgICAgICAgICAg
TU06Ojo6OjptOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNOjpNTTo6Ok1NCiAg
ICAgICAgICAgIE06Ojo6Ojo6Ok06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok06
Ok06OjpNTQogICAgICAgICAgIE1NOjo6Ojo6Ojo6TTo6Ojo6Ojo6Ojo6OjpNOjo6Ojo6Ojo6Ojo6
Ojo6Ojo6Ojo6TTpNOjo6TU0KICAgICAgICAgICBNOjo6Ojo6Ojo6OjpNODg6Ojo6Ojo6OjpNOjo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTTo6TU1NCiAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6Ojg4ODg4
ODg4ODhNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU06Ok1NCiAgICAgICAgICAgTTo6Ojo6Ojo6
Ojo6Ojo4ODg4ODg4OE06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TTo6TU0KICAgICAgICAgICBN
Ojo6Ojo6Ojo6Ojo6Ojo4ODg4ODhNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok06Ok1NCiAgICAg
ICAgICAgTTo6Ojo6Ojo6Ojo6Ojo6Ojg4ODg4TTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNOk1N
CiAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6Ojo6Ojo6ODhNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6
OjpNTU0KICAgICAgICAgICBNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ok06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6
Ojo6Ojo6Ok1NTQogICAgICAgICAgIE1NOjo6Ojo6Ojo6Ojo6Ojo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6
Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6Ojo6Ojo6TTo6Ojo6Ojo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgIE1NOjo6Ojo6Ojo6Ojo6Ojo6TTo6Ojo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICBNOjo6Ojo6Ojo6Ojo6Ojo6TTo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAgICAgIE1NOjo6Ojo6Ojo6Ojo6Ok06Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6OjpNOjo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgTU06Ojo6Ojo6Ojo6Ok06Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6TTo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgIE1NOjo6Ojo6Ojo6TTo6Ojo6Ojo6
Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICBNOjo6Ojo6Ojo6TTo6Ojo6Ojo6Ojo6
Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAgICAgICAgIE1NOjo6Ojo6Ok06Ojo6Ojo6Ojo6Ojo6Ojo6
Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICAgTU06Ojo6OjpNOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6
TU1NCiAgICAgICAgICAgICAgICAgTU06Ojo6Ok06Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU0KICAg
ICAgICAgICAgICAgICAgTU06Ojo6TTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAg
ICAgICAgIE1NOjo6TTo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICAgICBN
TTo6TTo6Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAgICAgICAgICAgIE1NOk06Ojo6Ojo6
Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6Ojo6Ojo6Ojo6
TU1NCiAgICAgICAgICAgICAgICAgICAgTU06Ojo6Ojo6Ojo6Ojo6Ojo6OjpNTU0KICAgICAgICAg
ICAgICAgICAgICAgTTo6Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICAgICAgTU06
Ojo6Ojo6Ojo6Ojo6Ojo6TU1NCiAgICAgICAgICAgICAgICAgICAgTU06Ojo6Ojo6Ojo6Ojo6OjpN
TU0KICAgICAgICAgICAgICAgICAgICBNTTo6OjpNOjo6Ojo6Ojo6TU1NOgogICAgICAgICAgICAg
ICAgICAgIG1NTTo6OjpNTTo6Ojo6OjpNTU1NCiAgICAgICAgICAgICAgICAgICAgIE1NTTo6Ojo6
Ojo6Ojo6TU1NOk0KICAgICAgICAgICAgICAgICAgICAgbU1NOjo6TTo6Ojo6OjpNOk06TQogICAg
ICAgICAgICAgICAgICAgICAgTU06Ok1NTU06Ojo6Ojo6TTpNCiAgICAgICAgICAgICAgICAgICAg
ICBNTTo6TU1NOjo6Ojo6OjpNOk0KICAgICAgICAgICAgICAgICAgICAgIG1NTTo6TU06Ojo6Ojo6
Ok06TQogICAgICAgICAgICAgICAgICAgICAgIE1NOjpNTTo6Ojo6Ojo6Ok06TQogICAgICAgICAg
ICAgICAgICAgICAgIE1NOjpNTTo6Ojo6Ojo6OjpNOm0KICAgICAgICAgICAgICAgICAgICAgICBN
TTo6Ok06Ojo6Ojo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6Ojo6
Ojo6TToKICAgICAgICAgICAgICAgICAgICAgICBNTU06Ojo6Ojo6Ojo6Ojo6OjpNOgogICAgICAg
ICAgICAgICAgICAgICAgIE1NTTo6Ojo6Ojo6Ojo6Ojo6OjpNCiAgICAgICAgICAgICAgICAgICAg
ICAgTU1NOjo6Ojo6Ojo6Ojo6Ojo6Ok0KICAgICAgICAgICAgICAgICAgICAgICBNTU06Ojo6Ojo6
Ojo6Ojo6Ojo6TW0KICAgICAgICAgICAgICAgICAgICAgICAgTU06Ojo6Ojo6Ojo6Ojo6Ojo6TU0K
ICAgICAgICAgICAgICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6Ojo6Ojo6TU0KICAgICAgICAgICAg
ICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6Ojo6Ojo6TU0KICAgICAgICAgICAgICAgICAgICAgICAg
TU1NOjo6Ojo6Ojo6Ojo6Ojo6TU0KICAgICAgICAgICAgICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6
Ojo6Ojo6TU0KICAgICAgICAgICAgICAgICAgICAgICAgIE1NOjo6Ojo6Ojo6Ojo6OjpNTU0KICAg
ICAgICAgICAgICAgICAgICAgICAgIE1NTTo6Ojo6Ojo6Ojo6OjpNTQogICAgICAgICAgICAgICAg
ICAgICAgICAgTU1NOjo6Ojo6Ojo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgICBNTU06
Ojo6Ojo6Ojo6OjpNTQogICAgICAgICAgICAgICAgICAgICAgICAgIE1NOjo6Ojo6Ojo6Ojo6TU0K
ICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6Ojo6Ojo6Ojo6Ok1NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgTU06Ojo6Ojo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgICAgTU1N
Ojo6Ojo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgICAgTU1NOjo6Ojo6Ojo6Ok1NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1NOjo6Ojo6Ojo6TU0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTU1NOjo6Ojo6OjpNTQogICAgICAgICAgICAgICAgICAgICAgICAgICBNTU06Ojo6
Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6Ojo6Ojo6TU0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1NTTo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNTU06Ojo6OjpNTQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NOjo6Ojo6TU0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6Ojo6Ok1NCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE1NOjo6OjpNTQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6Ojo6
TU06CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NOjo6OjpNOk0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTU06Ojo6Ok06TQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6TTo6Ojo6Ok06CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTTpNOjo6Ojo6Ok0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE06OjpNOjo6Ojo6TQogICAgICAgICAgICAgICAgICAg
ICAgICAgICBNOjo6Ok06Ojo6OjpNCiAgICAgICAgICAgICAgICAgICAgICAgICAgTTo6Ojo6TTo6
Ojo6OjpNCiAgICAgICAgICAgICAgICAgICAgICAgICBNOjo6Ojo6TU06Ojo6Ojo6TQogICAgICAg
ICAgICAgICAgICAgICAgICAgTTo6Ojo6OjpNOjo6Ojo6OjpNCiAgICAgICAgICAgICAgICAgICAg
ICAgICBNOzo7Ojo6Ok06Ojo6Ojo6OjpNCiAgICAgICAgICAgICAgICAgICAgICAgICBNOm06Ozo6
Ok06Ojo6Ojo6Ojo6TQogICAgICAgICAgICAgICAgICAgICAgICAgTU06bTptOjpNOjo6Ojo6Ojo7
Ok0KICAgICAgICAgICAgICAgICAgICAgICAgICBNTTptOjpNTTo6Ojo6Ojo7OjtNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1NOjpNTU06Ojo6Ojo7Om06TQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTU1NTSBNTTo6OjptOm06TU0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1NOjo6Om06TU0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6OjpN
TQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTTo6TU0K
' | base64 -d
}


#######
# print errors to stderr and exit with code 1
#
# @param errors
#
error() {
    echo "$@" >&2
    exit 1
}


#######
# print usage menu
#
print_usage()
{
    printf "%s\n" \
"usage: $pgm <local path> [new remote url]

    clones David's parcel2starterkit into <local path> folder
    sets name in package.json to foldername
    activates .gitignore file
    installs npm dependencies
    sets new remote url if provided

    make sure $pgm is in your PATH and executable (chmod +x $(basename "$0"))


example: $pgm myProject https://github.com/kermit/myProject.git"
}


#######
# print matrix-style animation
#
# @param bytes number of bytes to print
#
matrix_mode()
{
    local bytes="$1"
    LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom \
        | dd bs=10 cbs="$(tput cols)" conv=unblock \
        | head -c "$bytes" \
        | GREP_COLOR="1;32" grep --color "[^ ]"
}


#######
# parse arguments and set settings in global vars
#
# @global repo_path
# @global repo_name
# @global repo_url
# @global matrix
# @global nsfw
# @param args
#
parse_args()
{
    args=$(getopt -n "$0" \
        -o hmn \
        --long help,matrix,nsfw -- \
        "$@") || print_help

    eval set -- "$args"

    # option flags
    while true; do
        case "$1" in
            "-h" | "--help") print_usage && exit 0 ;;
            "-m" | "--matrix") matrix=true; shift ;;
            "-n" | "--nsfw") nsfw=true; shift ;;
            --) shift; break ;;
            *) echo "DEBUG getopt failed: $1" ;;
        esac
    done

    # remaining args - must be in proper order, url arg is optional
    [ -n "$1" ] && repo_path="$1"
    [ -n "$2" ] && repo_url="$2"
    [ -n "$3" ] && error "invalid argument \"$3\" - type $pgm --help"

    # at least the repo_path arg is required
    [ -n "$repo_path" ] \
        || error "please enter the local repo path, type $pgm -h for more info"
    repo_name="$(basename "$repo_path")"
}


#######
# set new git remote repository
#
# @param directory
# @param repository url
#
git_set_url()
{
    local path="$1"
    local url="$2"

    if [ -n "$url" ]; then

        # set the remote repository url for origin
        git -C "$path" remote set-url origin "$url" \
            || error "aborted setting new repo url"
            # actual error printed by git

        # ask git to print remote url
        echo "set-url:"
        git -C "$path" remote -v
    fi
}


######
# install npm dependencies from package.json
#
# @param directory
#
install_dependencies()
{
    local path="$1"

    if [ -d "$path" ]; then

        # make sure npm is installed
        command -v npm > /dev/null \
            || error "npm not installed, cannot install packages"

        # run npm install from within path folder
        # TODO: npm flag to install in directory instead of subshell + cd?
        echo "installing npm dependencies"
        (cd "$path" && npm install) \
            || error "failed to install npm dependencies"
    fi
}


################################################################################
##                                    main                                    ##
################################################################################

parse_args "$@"


# this script is useless if git is not installed
command -v git > /dev/null \
        || error "git not installed, cannot clone repository"


# complain if target folder or file exists
[ -d "$repo_path" ] && error "\"$repo_path\" already exists"
[ -f "$repo_path" ] && error "\"$repo_path\" is a file"


# clone
git clone --verbose "$starterkit_url" "$repo_path" \
    || error "aborted cloning"
echo -e "\nsuccessfully cloned into \"$repo_path\""


# replace "name" field in package.json
sed -i "s/\"name\":.*/\"name\": \"$repo_name\",/" "$repo_path/package.json"
echo "set repository name \"$repo_name\" in package.json"


# clean readme.md and set "name"
echo "# $repo_name" > "$repo_path/readme.md"
echo "set repository name \"$repo_name\" in readme.md"


# unignore the .gitignore
mv "$repo_path"/{\#,}.gitignore
git -C "$repo_path" add .gitignore
echo "activated .gitignore"


# untrack .env files
git -C "$repo_path" rm --cached .env.*


# intermission
if $nsfw; then nsfw_mode && sleep 3 && clear; fi


# npm dependencies
if $matrix; then
    # npm install while we waste precious entropy
    install_dependencies "$repo_path" &
    matrix_mode 40000000
    wait && clear
else
    install_dependencies "$repo_path"
fi


git_set_url "$repo_path" "$repo_url"


exit 0
