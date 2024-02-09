# 실습 강의
# https://www.youtube.com/watch?v=SLB_c_ayRMo&ab_channel=freeCodeCamp.org

# 테라폼 AWS 관련 입력어
# https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs


# - 테라폼에서 '개별 리소스 생성 블록'의 순서는 전혀 상관 없다!
#   '서브넷 생성 리소스 블록'을 'VPC 생성 리소스 블록' 위에 배치해도 아무 상관 없다!



provider "aws" {
    region = "us-east-1"
    access_key = "AKIAQQE4AOGT5QDRQHMF" 
    # 아래 과정으로 AWS 에서 Access Key 생성한다!
    # AWS 콘솔 ---> IAM ---> 특정 사용자 하나 클릭 ---> 상단 탭 Security Credentials ---> Access keys
    # ---> Create access key
    # 이렇게 AWS Access Key를 생성하고, 여기에 그 액세스 키와 시크릿 키를 입력해줌으로써, 
    # 여기 vscode의 Terraform에서 실제 AWS와 연동할 수 있는 것이다!!
    secret_key = "IeOPhay1n1Oc+Qh/LQOjzQYUD5jMYd2o2mTLD2ks"
}


# < AWS VPC 생성 - 첫 번째 VPC 생성 >
resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}




# < AWS VPC 생성 - 두 번째 VPC 생성 >
resource "aws_vpc" "second-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev"
  }
}




# < 위에서 생성한 첫 번째 VPC 내부에 서브넷 생성 >
resource "aws_subnet" "subnet-1" { # 'aws_subnet': 
                                   #  https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/subnet
                                   #  여기서 새로운 aws 서브넷을 생성하는 테라폼 입력어
  vpc_id = aws_vpc.first-vpc.id # 'aws_vpc': 위에서 생성한 첫 번째 VPC의 resource 바로 오른쪽에 있는 단어
                                # 'first-vpc': 위에서 생성한 여기 vsc에서만 사용할 VPC의 이름(실제 AWS에서의 해당
                                #              VPC의 이름이 아니다! 그냥 여기 코드로 입력할 때만 사용함)
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}




# < 위에서 생성한 두 번째 VPC 내부에 서브넷 생성 >
resource "aws_subnet" "subnet-2" { # 'aws_subnet': 
                                   #  https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/subnet
                                   #  새로운 aws 서브넷을 생성하는 테라폼 입력어
  vpc_id = aws_vpc.second-vpc.id # 'aws_vpc': 위에서 생성한 두 번째 VPC의 resource 바로 오른쪽에 있는 단어
                                # 'second-vpc': 위에서 생성한 여기 vsc에서만 사용할 VPC의 이름(실제 AWS에서의 해당
                                #                VPC의 이름이 아니다! 그냥 여기 코드로 입력할 때만 사용함)
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}




# < 새로운 EC2 인스턴스 생성 >
# resource "aws_instance" "my-first-server" {  # 'aws_instance': 
                                               # https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/subnet
                                               # 여기서 새로운 aws 인스턴스를 생성하는 테라폼 명령어
                                               # 'my-first-server': 생성할 여기 vsc에서만 사용할 인스턴스의 이름
                                               #                    (실제 AWS에서의 해당 인스턴스의 이름이 아니다! 
                                               #                     그냥 여기 코드로 입력할 때만 사용함)
#   ami           = "ami-0c7217cdde317cfec"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "ubuntu"
#   }

# }



# < 기본 형식 >

# resource "<provider>_<resource_type>" "name"{
#     config options ...
#     key = "value"    
#     key2 = "another value"    
# }