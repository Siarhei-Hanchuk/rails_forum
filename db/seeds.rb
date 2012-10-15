# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
u1=User.create(:login=>'user' ,:pass=>'user',:status=>0);
u2=User.create(:login=>'root' ,:pass=>'root',:status=>1,:email=>'siarheihanchuk@gmail.com');

Part.delete_all
p1=Part.create(:title=>'Part 1',:desc=>'p1')
p2=Part.create(:title=>'Part 2',:desc=>'p2')

Topic.delete_all
t1=Topic.create(:title=>'topic title1',:user_id=>u1.id,:part_id=>p1.id)
t2=Topic.create(:title=>'topic title2',:user_id=>u2.id,:part_id=>p2.id)
t3=Topic.create(:title=>'topic title3',:user_id=>u2.id,:part_id=>p2.id)

Post.delete_all
Post.create(:body=>'MSG1',:user_id=>u1.id,:topic_id=>t1.id)
Post.create(:body=>'MSG2',:user_id=>u1.id,:topic_id=>t1.id)
Post.create(:body=>'MSG3',:user_id=>u2.id,:topic_id=>t1.id)
Post.create(:body=>'MSG4',:user_id=>u2.id,:topic_id=>t2.id)
Post.create(:body=>'MSG5',:user_id=>u1.id,:topic_id=>t2.id)
Post.create(:body=>'MSG6',:user_id=>u2.id,:topic_id=>t2.id)
Post.create(:body=>'MSG7',:user_id=>u2.id,:topic_id=>t3.id)
Post.create(:body=>'MSG8',:user_id=>u1.id,:topic_id=>t3.id)
