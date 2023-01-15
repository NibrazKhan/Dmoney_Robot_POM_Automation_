import json
from faker import Faker
from robot.api.deco import library, keyword
import random
# from robot.libraries.BuiltIn import BuiltIn

@library
class BuiltinKeywords:

    def __init__(self):
        self.token=""
    # @keyword
    # def set_token(self,response):
    #     self.token = response['token']
    # @keyword
    # def get_token(self):
    #     return self.token
    @keyword
    def store_token_in_json(self, response,key):
       with open("../Dmoney_Robot_POM_Automation/Variables.json", "r") as out_file:
           json_data=json.load(out_file)
       with open("../Dmoney_Robot_POM_Automation/Variables.json", "w") as out_file:
            json_data[key] = response[key]
            json.dump(json_data,out_file,indent=2)
    @keyword
    def store_user_details_in_json(self,response,key,role):
        role_key=role+"_"+key
        new_dic={}
        with open("../Dmoney_Robot_POM_Automation/Variables.json", "r") as out_file:
            json_data=json.load(out_file)
        new_dic[role_key] = response['user'][key]
        json_data.update(new_dic)
        with open("../Dmoney_Robot_POM_Automation/Variables.json", "w") as out_file:
            json.dump(json_data, out_file, indent=2)

    @keyword
    def generate_random_data(self):
        fake = Faker()
        fake_data = []
        fake_data.append(fake.name())
        fake_data.append(fake.email())
        password = "pass" + str(random.randint(31, 345345))
        fake_data.append(password)
        fake_data.append('017' + str(random.randint(10000000, 99999999)))
        fake_data.append(random.randint(1000000000, 9999999999))
        return fake_data

    @keyword
    def validate_response_code(self, expected, actual):
        # BuiltIn.should_be_equal(self,expected,actual)
        if (expected == str(actual)):
            print("Passed")
        else:
            print("Failed")
