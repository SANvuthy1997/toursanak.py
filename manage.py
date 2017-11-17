#!/usr/bin/env python
from database import *
import os.path as op
import os
import flask
from flask import json,abort,Flask,g, render_template,request,session,redirect,url_for,flash
from werkzeug import secure_filename
from flask_wtf import Form
from wtforms import TextField, IntegerField, TextAreaField, SubmitField, RadioField,SelectField,validators, ValidationError
from flask_sijax import sijax
from flask.json import jsonify
import math
from models import *
from forms import *
from models import *
from random import randint
import logging
import time
logging.basicConfig()
template ="template-2016"
config_file=""
email=''
pwd=''
send_name=''
limit = 3
try:
	with open('config.txt','r') as f:
		config_file=str(f.read())
		data=config_file.split('\n')
		template=data[0].split('"')[1]
		limit=int(data[1].split('"')[1])
		email=data[2].split('"')[1]
		pwd=data[3].split('"')[1]
		send_name=data[4].split('"')[1]
except Exception as e:
	print e.message
########## End Configuration ############
#### config mail ####
email="amoogli.web@gmail.com"
pwd="AmoogliWeb2017*$$$"
app.config.update(
    DEBUG=True,
    # EMAIL SETTINGS
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME=email,
    MAIL_PASSWORD=pwd)
mail = Mail(app)
#####################

#### send mail ####
def send_mail(headers, emails, recipient):
    msg = Message(headers, sender=email, recipients=[recipient])
    message_string = emails
    msg.html = message_string
    mail.send(msg)
#####################


#Middleware
# header_image=random.choice (arr_header_image)
@app.context_processor
def inject_dict_for_all_templates():
    return dict(searchform=SearchForm(),logined_name=request.cookies.get('blog_name'),template_name= template,categories = Category.query.filter_by(is_menu=1),pages = Page.query.filter_by(is_menu=1))
#========================================================
@auth.verify_token
def verify_token(token):
	user = UserMember.query.filter_by(email = request.cookies.get('blog_email'))
	if user.count()>0:
		for user_object in user:
			if user_object.verify_password(request.cookies.get('blog_password')):
				return True
	return False
@auth.error_handler
def goLoginPage():
	return redirect(url_for("admin_login"))
#================
@auth.login_required
def get_auth_token():
    token = g.user.generate_auth_token()
    return jsonify({ 'token': token.decode('ascii') })
@app.route('/download/<name>')
def download(name=''):
	return send_file('static/files/'+name,
                     mimetype='text/csv',
                     attachment_filename=name,
                     as_attachment=True)
@app.route('/admin/config', methods=['POST', 'GET'])
@app.route('/admin/config/', methods=['POST', 'GET'])
def config():
	global email
	global pwd
	global send_name
	global template
	global limit
	if request.method == 'GET':
		return render_template("admin/form/config.html",name=send_name,email=email,password=pwd)
	else:
		try:
			email = request.form['email']
			send_name=request.form['name']
			pwd = request.form['password']
			
			dataToSave = 'Template="'+template+'";\nlimit="'+str(limit)+'";\nemail="'+email+'";\npassword="'+pwd+'";\nname="'+send_name+'";\n'
			file=open("config.txt","w")
			file.write(dataToSave)
			flash("Configuratin saved successfully")
		except Exception as e:
			flash(e.message)
			return render_template(url_for("config"))
		return redirect(url_for("config"))

@app.route('/admin/login', methods=['POST', 'GET'])
@app.route('/admin/login/', methods=['POST', 'GET'])
def admin_login():
	form = UserMemberForm()
	if request.method == 'POST':
		email_form = request.form['email']
		password_form = request.form['password']
		user = UserMember.query.filter_by(email=email_form)
		if user.count()>0:
				#"set session"
				check=0
				for user_object in user:
					#return "{}".format(user_object.verify_password(password_form))
					if user_object.verify_password(password_form):
						response = make_response(redirect('/admin'))
						response.set_cookie("blog_id",str(user_object.id), expires=expire_date)
						response.set_cookie("blog_name",user_object.name, expires=expire_date)
						response.set_cookie("blog_email",user_object.email, expires=expire_date)
						response.set_cookie("blog_password",password_form, expires=expire_date)
						return response
					else:
						flash('Wrong user name or password !')
						return redirect(url_for("admin_login"))
		else:
			flash('Wrong user name or password !')
			return redirect(url_for("admin_login"))
	elif request.method == 'GET':
		#return str(request.cookies.get("blog_name"))
		if request.cookies.get("blog_name"):
			return redirect(url_for("admin_index"))
		return render_template('admin/form/login.html',form = form)
@app.route('/admin/logout', methods=['POST', 'GET'])
@app.route('/admin/logout/', methods=['POST', 'GET'])
# @auth.login_required
def logout():
	response = make_response(redirect('/'))
	response.set_cookie("blog_id","", expires=0)
	response.set_cookie("blog_name","", expires=0)
	response.set_cookie("blog_email","", expires=0)
	response.set_cookie("blog_password","", expires=0)
	return response
@app.route('/admin/register', methods=['POST', 'GET'])
@app.route('/admin/register/', methods=['POST', 'GET'])
#@auth.login_required
def admin_register():
	form = UserMemberForm()
	if request.method == 'POST':
		user=UserMember(request.form['name'],request.form['email'],request.form['password'])
		user.hash_password(request.form['password'])
		try:
			status=UserMember.add(user)
			if not status:
				flash("User Added successfully")
				return redirect(url_for('admin_login'))
			else:
				flash("Error in adding User !")
				return redirect(url_for('admin_register'))	
		except:
			flash("Error in adding User !")
			return redirect(url_for('admin_register'))
	return render_template('admin/form/register.html', form = form)
@app.route('/ckupload/', methods=['POST', 'OPTIONS'])
def ckupload():
    form = PostForm()
    response = form.upload(endpoint=app)
    return response

########### member  ##########
@app.route('/admin/member', methods=['POST', 'GET'])
@app.route('/admin/member/', methods=['POST', 'GET'])
@app.route('/admin/member/<action>', methods=['POST', 'GET'])
@app.route('/admin/member/<action>/', methods=['POST', 'GET'])
@app.route('/admin/member/<action>/<slug>/', methods=['POST', 'GET'])
@app.route('/admin/member/<action>/<slug>', methods=['POST', 'GET'])
@app.route('/admin/member/pagin/<pagination>/')
@app.route('/admin/member/pagin/<pagination>')
@auth.login_required
def admin_member(pagination=1,action='',slug=''):
	form = MemberForm()
	if action=='add':
		#add event
		# return str(request.method)
		if request.method == 'GET':
			return render_template("admin/form/member.html",form=form)
		else:
			#try:
			# filename=str(request.form['txt_temp_image'])
			f = request.files['feature_image']
			now = str(datetime.now())
			now= now.replace(':',"",10).replace(' ','',4).replace('.','',5).replace('-','',5)

			help_filename = secure_filename(f.filename)
			filename=now+'-'+secure_filename(f.filename)
			#upload feature image
			if help_filename!='':
				f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
			else:
				filename=''			
			images=''
			member = Member(request.form['name'],request.form['possition'],request.form['detail'],filename)
        	
        	status = Member.add(member)
	        if not status:
	            flash("Member added successfully")
	            return redirect(url_for('admin_member'))
	       	else:
	       		flash("Fail to add member !")
	       		return redirect(url_for('admin_member'))
		    # except Exception as e:
		    # 	flask(e.message)
		    # 	return redirect(url_for("admin_event"))
	elif action=='edit':
		#return 'update'+ slug
		members=Member.query.filter_by(slug=slug)
		if request.method == 'GET':
			return render_template("admin/form/member.html",form=form,member_object=members)
		else:
			try:
				now = str(datetime.now())
				now= now.replace(':',"",10).replace(' ','',4).replace('.','',5).replace('-','',5)
		
				f = request.files['feature_image']
				help_filename = secure_filename(f.filename)
				filename=now+'-'+secure_filename(f.filename)
				#upload feature image
				if help_filename!='':
					f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
				else:
					filename=''	
				if filename=='':
					members.update({"slug" : slugify(request.form['name']) , "name" : request.form['name'],'possition':request.form['possition'],'detail':request.form['detail']})
				else:
					members.update({"slug" : slugify(request.form['name']) , "name" : request.form['name'],'possition':request.form['possition'],'detail':request.form['detail'],'feature_image':filename})
		   		status = db.session.commit()
				flash("Member updated successfully.")
				return redirect(url_for("admin_member"))
			except Exception as e:
				flash(e.message)
				return redirect(url_for("admin_member"))
	elif action=='delete':
		# return action+"...."
		try:
			member=Member.query.filter_by(slug=slug).first()
			status = Member.delete(member)
			flash('Member deleted successfully.')
			return redirect(url_for('admin_member'))
		except Exception as e:
			flash('Fail to delete member. '+ e.message)
			return redirect(url_for('admin_member'))
	else:
		members=Member.query.all()
		member=Member.query.order_by(Member.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Member.query.count())/limit)
		if((Member.query.count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template("admin/member.html",current_pagin=int(pagination),members=members,pagin=int(pagin))

############ End member ##########



# ############  Contact List ##########
@app.route('/admin/contact/')
@app.route('/admin/contact')
@app.route('/admin/contact/<action>/<firstname>')
@app.route('/admin/contact/<action>/<firstname>/')
@app.route('/admin/contact/<pagination>/')
@app.route('/admin/contact/<pagination>/')
@app.route('/admin/contact/<pagination>')
@app.route('/admin/contact/<pagination>/')
@auth.login_required
def admin_contact(pagination=1,action='',firstname=''):
	if action=='delete':		
		try:
			contact=Contact.query.filter_by(firstname=firstname).first()
			status = Contact.delete(contact)
			flash('Contact info deleted successful.')
			return redirect(url_for('admin_contact'))
		except Exception as e:
			flash('Fail to delete Contact info. '+ e.message)
			return redirect(url_for('admin_contact'))
	else:
		contacts=Contact.query.order_by(Contact.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Contact.query.count())/limit)
		if((Contact.query.count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template('admin/contact.html',contacts=contacts,current_pagin=int(pagination),pagin=int(pagin))

# @app.route('/add/contact/<type_submit>/',methods=['POST'])
# @app.route('/add/contact/<type_submit>',methods=['POST'])
# @app.route('/add/contact',methods=['POST'])
# @app.route('/add/contact/',methods=['POST'])
# def contact(type_submit=''):
# 	if type_submit=="":
# 		if(Contact.query.filter_by(email=request.form['email']).count()>0):
# 			flash("Email already exists.")
# 			return redirect(url_for('single',slug='contact'))
# 		contact=Contact(request.form['firstname'],request.form['lastname'],request.form['email'],request.form['comment'])
# 		status = Contact.add(contact)
#         if not status:
#         	flash("Contact info saved successfully")
#         	return redirect(url_for('single',slug='contact'))
#        	else:
#        		flash("Error in contact")
#        		return redirect(url_for('single',slug='contact'))



@app.route('/mail/<slug>')
@app.route('/mail/<slug>/')
def TestHello1( slug = ''):
	if slug == '/index/':
		return redirect(url_for('single',slug='contact'))
	else:
		return render_template('toursanak/contact.html')

#send contact mail 
# @app.route('/mail', methods=['GET'])
# @app.route('/mail/', methods=['GET'])
# @app.route('/mail/<action>', methods=['POST'])
# @app.route('/mail/<action>/', methods=['POST'])
# def contactMail(action=""):
# 	if request.method == 'POST':
# 		if action == 'send':
# 			email_header = 'New Contact'
# 			# recipients = 'san.vuthy08@gmail.com'
# 			recipients = 'san.vuthy08@gmail.com'
# 			body = 'Someone have had a question to ask you through toursanak.com with their info is: <br> Name: '+ request.form['fname'] +" "+request.form['lname']+' <br> Email: '+request.form['email']+" <br> Question: "+ request.form ['msg']
# 			if request.form['fname'] =="" and request.form['lname'] =="" and request.form['email'] =="" and request.form['msg'] =="":
# 				flash('You were successfully to send the question')
# 				return redirect(url_for("TestHello1",slug = 'contact'))
# 			else:
# 				send_mail(email_header, body, recipients)
# 				# flash('You were successfully to send the question')
# 				return redirect(url_for("TestHello1",slug = 'contact'))
# 		else:
# 			flash('Error sending the message')
# 			return render_template("template+'index.html")
# 	else:
# 		return render_template("template+'index.html")

@app.route('/contactUs/<slug>')
@app.route('/contactUs/<slug>/')
def TestHello( slug = ''):
	if slug == '/send/':
		return redirect(url_for('single',slug='contact'))
	else:
		return render_template('toursanak/contact.html') 

#send contact mail 
@app.route('/contactUs', methods=['GET'])
@app.route('/contactUs/', methods=['GET'])
@app.route('/contactUs/<action>', methods=['POST'])
@app.route('/contactUs/<action>/', methods=['POST'])
def contactUs(action=""):
	if request.method == 'POST':
		if action == 'send':
			email_header = 'New Contact'
			# recipients = 'san.vuthy08@gmail.com'
			recipients = 'san.vuthy08@gmail.com'
			body = 'Someone have had contact you through toursanak.com with their info is: <br> Name: '+ request.form['fname'] +" "+request.form['lname']+' <br> Email: '+request.form['email']+" <br> Message: "+ request.form ['msg']
			if request.form['email'] == "":
				flash('All input require')
				return redirect(url_for("TestHello",slug = 'send'))
			else:
				send_mail(email_header, body, recipients)
				flash('Your message has been sent successfully. We will get back to you ASAP.')
				return redirect(url_for("TestHello",slug = 'send'))
		else:
			flash('Error sending the message')
			return render_template("template+'index.html")
	else:
		return render_template("template+'index.html")

#send Book Tour 

@app.route('/bookTour/<slug>', methods=['GET'])
@app.route('/bookTour/<slug>/', methods=['GET'])
@app.route('/bookTour/<slug>/<action>', methods=['POST','GET'])
@app.route('/bookTour/<slug>/<action>/', methods=['POST','GET'])
def BookTour(action="", slug=''):
	if request.method == 'POST':
		if action == 'send':
			email_header = 'New Contact'
			# recipients = 'san.vuthy08@gmail.com'
			recipients = 'san.vuthy08@gmail.com'
			body = 'Someone had book a tour from toursanak.com with there info is: ' \
				  '<br> Start: '+ request.form['startDate'] \
			      +" <br> End Date: "+ request.form['endDate'] \
			      +" <br> Total of people: " + request.form ['person'] \
			      + "<br/> Email:" + request.form ['email'] \
			      + "<br/> Tour Title: " + request.form["nameTour"]
			if request.form['startDate'] == "" and request.form['endDate'] == "":
				flash('Sorry please input start date and end date')
				return redirect(url_for('single',slug=slug))
			else:
				send_mail(email_header, body, recipients)
				flash('Your message has been sent successfully. We will get back to you ASAP.')
				return redirect(url_for('single',slug=slug))
		else:
			flash('Error sending the message')
			return redirect(url_for('contactMail'))
	else:
		return render_template(template+'/index.html')


#send Book Tour 
@app.route('/Tours/<slug>', methods=['GET'])
@app.route('/Tours/<slug>/', methods=['GET'])
@app.route('/Tours/<slug>/<action>', methods=['POST'])
@app.route('/Tours/<slug>/<action>/', methods=['POST'])
def Tours(action="", slug=''):
	if request.method == 'POST':
		if action == 'send':
			email_header = 'New Contact'
			# recipients = 'san.vuthy08@gmail.com'
			recipients = 'san.vuthy08@gmail.com'
			body = 'Someone had book a tour from toursanak.com with there info is: ' \
				  '<br> Start: '+ request.form['startDate'] \
			      +" <br> End Date: "+ request.form['endDate'] \
			      +" <br> Total of people: " + request.form ['person'] \
			      + "<br/> Email:" + request.form ['email'] \
			      + "<br/> Tour Title: " + request.form["nameTour"]
			send_mail(email_header, body, recipients)
			flash('Your message has been sent successfully. We will get back to you ASAP.')
			return redirect(url_for('single',slug=slug))
		else:
			flash('Error sending the message')
			return redirect(url_for('contactMail'))
	else:
		return render_template(template+'/index.html')


#send Custom Tour Detail
@app.route('/customPrice/<slug>', methods=['GET'])
@app.route('/customPrice/<slug>/', methods=['GET'])
@app.route('/customPrice/<slug>/<action>', methods=['POST','GET'])
@app.route('/customPrice/<slug>/<action>/', methods=['POST','GET'])
def customPrice(action="", slug=''):
	if request.method == 'POST':
		if action == 'send' and slug == "development-and-culture-program" or slug == "family-trip-adventure":
			email_header = 'New Contact'
			# recipients = 'san.vuthy08@gmail.com'
			recipients = 'san.vuthy08@gmail.com'
			body = 'Someone had book toursanak.com with their info is: ' \
				  '<br> Date: '+ request.form['date'] \
			      +" <br> Price: "+ request.form['prices'] \
			      + "<br/> Email:" + request.form ['email'] \
			      + "<br/> Full Name: " + request.form["name"]
			if request.form['date']=="" and request.form ['email']=="":
				flash('All input require!!! ')
				return redirect(url_for('tours',slug=slug))
			else:
				send_mail(email_header, body, recipients)
				flash('Your message has been sent successfully. We will get back to you ASAP.')
				return redirect(url_for('tours',slug=slug))
		else:
			flash('Error sending the message')
			return redirect(url_for('customPrice'))
	else:
		return render_template(template + '/index.html')



############ End Contact List ##########

############ Partner  ##########
@app.route('/admin/partner', methods=['POST', 'GET'])
@app.route('/admin/partner/', methods=['POST', 'GET'])
@app.route('/admin/partner/<action>', methods=['POST', 'GET'])
@app.route('/admin/partner/<action>/', methods=['POST', 'GET'])
@app.route('/admin/partner/<action>/<slug>/', methods=['POST', 'GET'])
@app.route('/admin/partner/<action>/<slug>', methods=['POST', 'GET'])
@app.route('/admin/partner/pagin/<pagination>/')
@app.route('/admin/partner/pagin/<pagination>')
@auth.login_required
def admin_partner(pagination=1,action='',slug=''):
	form = PartnerForm()
	now = str(datetime.now())
	now= now.replace(':',"",10).replace(' ','',4).replace('.','',5).replace('-','',5)
			
	if action=='add':
		#add event
		# return str(request.method)
		if request.method == 'GET':
			return render_template("admin/form/partner.html",form=form)
		else:
			# filename=str(request.form['txt_temp_image'])
			f = request.files['feature_image']
			help = secure_filename(f.filename)
			filename=now+'-'+secure_filename(f.filename)
			#upload feature image
			if help!='':
				f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
			else:
				filename=''
			partner = Partner(request.form['name'],request.form['url'],filename,request.form['description'])
        	# return str('event')
        	status = Partner.add(partner)
	        if not status:
	            flash("Partner added was successfully")
	            return redirect(url_for('admin_partner'))
	       	else:
	       		flash("Fail to add partner !")
	       		return redirect(url_for('admin_partner'))
	elif action=='edit':
		partners=Partner.query.filter_by(slug=slug)
		if request.method == 'GET':
			return render_template("admin/form/partner.html",form=form,partner_object=partners)
		else:
			try:
				help=''
				f = request.files['feature_image']
				if help!='':
					
					filename=now+'-'+help
					#upload feature image
					if help!='':
						f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
					else:
						filename=''
					partners.update({"slug" : slugify(request.form['name']) , "name" : request.form['name'],'url':request.form['url'],'feature_image':filename ,'description':request.form['description']})
			   		status = db.session.commit()
			   	else:
					partners.update({"slug" : slugify(request.form['name']) , "name" : request.form['name'],'url':request.form['url'],'description':request.form['description']})
			   		status = db.session.commit()

				flash("Partner updated successfully.")
				return redirect(url_for("admin_partner"))
			except Exception as e:
				flash(e.message)
				return redirect(url_for("admin_partner"))
	elif action=='delete':
		# return action+"...."
		try:
			partner=Partner.query.filter_by(slug=slug).first()
			status = Partner.delete(partner)
			flash('Partner deleted successfully.')
			return redirect(url_for('admin_partner'))
		except Exception as e:
			flash('Fail to delete partner. '+ e.message)
			return redirect(url_for('admin_partner'))
	else:
		partners=Partner.query.order_by(Partner.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Partner.query.count())/limit)
		if((Partner.query.count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template("admin/partner.html",current_pagin=int(pagination),partners=partners,pagin=int(pagin))

############ End Partner ##########
@app.route('/admin')
@app.route('/admin/post')
@app.route('/admin/')
@app.route('/admin/<pagination>')
@auth.login_required
def admin_index(pagination=1):
	posts=Post.query.join(Category,Post.category_id == Category.id).order_by(Post.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
	pagin=math.ceil((Post.query.join(Category,Post.category_id == Category.id).count())/limit)
	if((Post.query.count())%limit != 0 ):
		pagin=int(pagin+1)
	return render_template('admin/index.html' , posts = posts , pagin = int(pagin) , current_pagin = int(pagination))


@app.route('/admin/post/add', methods = ['GET', 'POST'])
@app.route('/admin/post/add/', methods = ['GET', 'POST'])
@app.route('/admin/post/edit/<slug>', methods = ['GET', 'POST'])
@app.route('/admin/post/edit/<slug>/', methods = ['GET', 'POST'])
@auth.login_required
def admin_post_add(slug=""):
	form = PostForm()
	categories = [(c.id, c.name) for c in Category.query.order_by(Category.name).all()]
	form.category_id.choices = categories
	now = str(datetime.now())
	now= now.replace(':',"",10).replace(' ','',4).replace('.','',5).replace('-','',5)
		   		
	if request.method == 'POST':
		# filename=str(request.form['txt_temp_image'])
		# print filename
		try:
			# if form.validate() == False:
			if False:
		   		flash('Please try to fill the form again.')
		   		return redirect(url_for('admin_post_add'))
		   	else:
		   		obj=Post.query.filter_by(slug=slug)
		   		
		   		for post in obj:
		   			old_images=post.images
		   		result = request.form
				# filename=str(request.form['txt_temp_image'])
				f = request.files['feature_image']
				help_filename = secure_filename(f.filename)
				filename=now+'-'+secure_filename(f.filename)
				#upload feature image
				if help_filename!='':
					f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
				else:
					filename=''			
				images=''
				# return filename
				if not slug:
					images=''
	   				help=1
   					uploaded_files = flask.request.files.getlist("other_image[]")
	   				# return filename
	   				images = ''
	   				for f in uploaded_files:
	   					imagename = secure_filename(f.filename)
	   					if imagename!="":
	   						f.save(os.path.join(app.config['UPLOAD_FOLDER'], now+"-"+imagename))
		   					if help==1:
		   						images=now+"-"+imagename
		   					else:
		   						images=images+"$$$$$"+(now+"-"+imagename)
		   					help=help+1
			        	ob=Post(request.form['title'],request.form['description'],request.form.get('category_id'),filename,request.cookies.get('blog_id'),0,images,request.form['price'],request.form['date'],request.form['participants'],request.form['cost'],request.form['shortdec'],request.form['keyword'])
			        	status=Post.add(ob)
				        if not status:
				        	flash("Post added successfully")
				        	return redirect(url_for('admin_index'))
				        else:
				        	flash("Fail to add post !")
				        	return redirect(url_for('admin_post_add'))
				elif slug:
	   				images=''
	   				help=1
   					uploaded_files = flask.request.files.getlist("other_image[]")
	   				# return filename
	   				
	   				for f in uploaded_files:
	   					imagename = secure_filename(f.filename)
	   					if imagename!="":
		   					f.save(os.path.join(app.config['UPLOAD_FOLDER'], now+"-"+imagename))
		   					if help==1:
		   						images=now+"-"+imagename
		   					else:
		   						images=images+"$$$$$"+(now+"-"+imagename)
		   					help=help+1
		   			if old_images!='':
			   			if images!='':
			   				images=old_images+"$$$$$"+images
			   			else:
			   				images=old_images
		   			#keep old other images

			   		for post in obj:
			   			old_images=post.images
			   		arr_to_remove=(request.form['all_removed_images']).split("$$$$$")
			   		for item in arr_to_remove:
			   			images=images.replace(item,'')
			   		images=images.replace('$$$$$$$$$$','$$$$$')
			   		#end keep old images

			   		# Upuload feature image if new upload
			   		# feature_img = request.files['feature_image']
					# help = secure_filename(feature_img.filename)
					# filename=now+'-'+secure_filename(feature_img.filename)
					#upload feature image
					# return filename
					# if help!='':
					# 	feature_img.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
					# else:
					# 	filename=''

			   		if filename!="":
   						obj.update({"slug" : slugify(request.form['title']) , "title" : request.form['title'],'description':request.form['description'],"category_id":request.form['category_id'],'feature_image':filename,'images':images,'price':request.form['price'], 'date':request.form['date'],'participants':request.form['participants'], 'cost':request.form['cost'],'shortdec':request.form['shortdec'],'keyword':request.form['keyword']})
   					else:
   						obj.update({"slug" : slugify(request.form['title']) , "title" : request.form['title'],'description':request.form['description'],"category_id":request.form['category_id'],'images':images,'price':request.form['price'], 'date':request.form['date'],'participants':request.form['participants'], 'cost':request.form['cost'],'shortdec':request.form['shortdec'],'keyword':request.form['keyword']})
   					
   					status = db.session.commit()
	   				if not status:
	   					flash("Post updated successfully")
	   					return redirect(url_for('admin_index'))
	   				else:
	   					return 'else'
		   			for post in obj:
		   				tempFileName=post.feature_image
	   				# filename=tempFileName
	   				obj.update({"slug" : slugify(request.form['title']) , "title" : request.form['title'],'description':request.form['description'],'category_id':request.form['category_id'],'feature_image':filename,'price':request.form['price'],'date':request.form['date'], 'participants':request.form['participants'], 'cost':request.form['cost'],'shortdec':request.form['shortdec'],'keyword':request.form['keyword']})
	   				status = db.session.commit()
	   				if not status:
	   					flash("Post updated was successfully")
	   					return redirect(url_for('admin_index'))
			        else:
			        	flash("Fail to update post!")
			        	return redirect(url_for('admin_index'))
		except Exception  as e:
			flash(str(e.message))
			return redirect(url_for("admin_post_add"))
	elif request.method == 'GET':
		if slug:
			post=Post.query.filter_by(slug=slug)
			return render_template('admin/form/post.html', post = post, form = form)
		else:
			return render_template('admin/form/post.html', form = form)
@app.route('/admin/category', methods = ['GET', 'POST'])
@app.route('/admin/category/', methods = ['GET', 'POST'])
@app.route('/admin/category/add', methods = ['GET', 'POST'])
@app.route('/admin/category/add/', methods = ['GET', 'POST'])
@app.route('/admin/category/edit/<slug>', methods = ['GET', 'POST'])
@app.route('/admin/category/edit/<slug>/', methods = ['GET', 'POST'])
@auth.login_required
def admin_category_add(slug=""):
	form = CategoryForm()
	categories= Category.query.order_by(Category.name)
	if request.method == 'POST':
		try:
			if form.validate() == False:
		   		flash('please input category name !')
		   		return redirect(url_for('admin_category_add'))
	   		if not slug:
	   			#add category
		   		obj=Category(request.form['name'])
		   		status=Category.add(obj)
				if not status:
					flash("Category Added successfully")
					return redirect(url_for('admin_category_add'))
				else:
					flash("Error in adding page !")
					return redirect(url_for('admin_category_add'))	
			elif slug:
				#update category
	   			Category.query.filter_by(slug = slug).update({"slug" : slugify(request.form['name']) , "name" : request.form['name'] })
	   			status = db.session.commit()
	   			if not status:
	   				flash("Category updated successfully")
	   				return redirect(url_for('admin_category_add'))
		        else:
		        	flash("Error in updating category !")
		        	return redirect(url_for('admin_category_add'))
		except Exception as e:
			flash(str(e.message))
			return redirect(url_for("admin_category_add"))
	elif request.method == 'GET':
		if not slug:
			return render_template('/admin/form/category.html',categories=categories, form = form)
		else:
			cat= Category.query.filter_by(slug=slug)
			return render_template('/admin/form/category.html',categories=categories,cat=cat, form = form)
@app.route('/admin/page/')
@app.route('/admin/page')
@app.route('/admin/page/<pagination>')
@auth.login_required
def admin_page(pagination=1):
	pages = Page.query.order_by(Page.id.desc())
	return render_template('admin/page.html', pages=pages)
@app.route('/admin/page/add', methods = ['GET', 'POST'])
@app.route('/admin/page/add/', methods = ['GET', 'POST'])
@app.route('/admin/page/edit/<slug>/', methods = ['GET', 'POST'])
@app.route('/admin/page/edit/<slug>', methods = ['GET', 'POST'])
@auth.login_required
def admin_page_add(slug=''):
	form = PageForm()
	if request.method == 'POST':
		try:
			if False:
		   		flash('All fields are required !'	)
		   		return redirect(url_for('admin_page_add'))
		   	else:
		   		if not slug:
		   			#add new
			   		obj=Page(request.form['title'],request.form['description'])
			   		status=Page.add(obj)
					if not status:
						flash("Page Added successfully")
						return redirect(url_for('admin_page'))
					else:
						flash("Error in adding page !")
						return redirect(url_for('admin_page_add'))
		   		elif slug:
		   			Page.query.filter_by(slug = slug).update({"slug" : slugify(request.form['title']) , "title" : request.form['title'] , "description" : request.form['description']})
		   			status = db.session.commit()
		   			if not status:
		   				flash("Page updated successfully")
		   				return redirect(url_for('admin_page'))
			        else:
			        	flash("Error !")
			        	return redirect(url_for('admin_page_add'))
		except Exception as e:
			flash(str(e.message))
			return redirect(url_for("admin_page_add"))
	else:
		if not slug:
			return render_template('/admin/form/page.html', form = form)
		else:
			page= Page.query.filter_by(slug=slug)
			return render_template('/admin/form/page.html',page=page, form = form)
@app.route('/admin/page/delete/<slug>/')
@app.route('/admin/page/delete/<slug>')
@auth.login_required
def admin_page_delete(slug=''):
	obj1 = Page.query.filter_by(slug=slug).first()
	try:
		status = Page.delete(obj1)
		flash('Deleted successful.')
		return redirect(url_for('admin_page'))
	except:
		flash('Fail to delete !')
		return redirect(url_for('admin_page'))
@app.route('/admin/category/delete/<slug>')
@app.route('/admin/category/delete/<slug>/')
@auth.login_required
def admin_category_delete(slug):	
	obj1 = Category.query.filter_by(slug=slug).first()
	try:
		status = Category.delete(obj1)
		flash('Deleted successful.')
		return redirect(url_for('admin_category_add'))
	except:
		flash('Fail to delete !')
		return redirect(url_for('admin_category_add'))

@app.route('/admin/post/delete/<slug>')
@app.route('/admin/post/delete/<slug>/')
@auth.login_required
def admiin_post_delete(slug=''):
	obj = Post.query.filter_by(slug=slug).first()
	try:
		status = Post.delete(obj)
		flash('Post deleted successfully')
		return redirect(url_for('admin_index'))
	except Exception as e:
		flash(str(e.message))
		return redirect(url_for('admin_index'))

@app.route('/admin/limit')
@app.route('/admin/limit/')
@app.route('/admin/limit/<number>', methods=['POST','GET'])
@app.route('/admin/limit/<number>/', methods=['POST','GET'])
@auth.login_required
def admin_limit(number=0):
	global config_file
	global template
	global limit
	global email
	if number==0:
		return render_template('/admin/limit.html',limit=limit)
	else:
		try:
			#return config
			with open('config.txt','w') as f:
				config_file=config_file.replace('limit="'+str(limit)+'"','limit="'+str(number)+'"')
				f.write(str(config_file))
			###Read again:
			with open('config.txt','r') as f:
				config_file=str(f.read())
				data=config_file.split('\n')
				template=data[0].split('"')[1]
				limit=int(data[1].split('"')[1])
				email=data[2].split('"')[1]
				pwd=data[3].split('"')[1]
				send_name=data[4].split('"')[1]
			return jsonify({'success':"Ok" })
		except Exception as e:
			return jsonify({'success':str(e.message) })

@app.route('/recovery',methods=["POST","GET"])
@app.route('/recovery/',methods=["POST","GET"])
def verify_email():
	if request.method=="GET":
		return render_template('admin/verify-email.html')
	else:
		your_passowrd=''
		email_temp=request.form['email']
		users=UserMember.query.filter_by(email=email_temp)
		for usr in users:
			your_passowrd=usr.password2
			your_name=usr.name
		if your_passowrd!="":
			#send email
			try:
				global email
				#return email+":"+email_temp+":"+pwd
				msg = Message('Password recovery',sender=email,recipients=[email_temp])
				message_string='<div style="width:400px;border:2px solid blue;padding:10px;">Hello '+your_name+',<br/> Your password is: <b>'+your_passowrd+'</b></b> Thanks for choosing Amogli service.<br/></div>'
				msg.html = message_string
				mail.send(msg)				
				flash("Please check your email to recovery the password.")
				return redirect(url_for("admin_login"))
			except Exception as e:
				raise
				return str(e.message)
		else:
			#wrong email
			flash("Sorry, We couldn't find this email to recovery you password. It might wrong email address")
			return render_template('admin/verify-email.html')
			return "We couldn't find this email."
		# time.sleep(random_time)

@app.route('/admin/email', methods = ['GET', 'POST'])
@app.route('/admin/email/', methods = ['GET', 'POST'])
@auth.login_required
def admin_email():
	email_to_send = EmailList.query.count()
	if request.method=="GET":
		groups=Group.query.order_by(Group.id.desc())
		return render_template("admin/form/sendmail.html",name=send_name,email=email,password=pwd,email_to_send=email_to_send,groups=groups)
	else:
		global subject
		global description
		global group_send
		global sched
		# sched = Scheduler()
		subject = request.form['subject']
		description = request.form['description']
		reply_to = request.form['reply_to']
		groups = request.form.getlist('groups')
		sending_email= request.form['send_from']
		sending_password= request.form['password']
		sending_name= request.form['name']
		# return 'dd'
		if reply_to=="":
			reply_to = email
		for group in groups:
			# print str(group)+"========="
			group_send.append(int(group))
			# obj=Emailgroup.query.join(Email,Emailgroup.email_id==Email.id).filter(Emailgroup.group_id==int(group))
			obj=Emailgroup.query.filter(Emailgroup.group_id==int(group))
			for o in obj:
				tmp=Email.query.filter_by(id=o.email_id)
				for t in tmp:
					#add to email list to send 
					try:
						help=EmailList.query.filter_by(email=t.email)
						if help.count()<=0:
							temp_object = EmailList(t.firstname,t.email,subject,description,reply_to,sending_email,sending_password,sending_name)
							EmailList.add(temp_object)
						# else:
						# 	print "Email already exists."
					except Exception as e:
						print e.message
		email_to_send = EmailList.query.count()
		sched.add_interval_job(sendEmail, seconds=10) #120 seconds
		sched.start()
		flash("Your Email will be sent successfully.")
		groups = Group.query.all()
		return render_template("admin/form/sendmail.html",email=email,password=pwd,email_to_send=email_to_send,groups=groups)

@app.route('/admin/earn')
@app.route('/admin/earn/')
def admin_earn():
	return render_template("admin/earn.html")
@app.route('/admin/user')
@app.route('/admin/user/')
@auth.login_required
def usermember():
	users=UserMember.query.all()
	return render_template('admin/user.html',users=users)
@app.route('/admin/search')
@app.route('/admin/search/')
@app.route('/admin/search/<pagination>')
@app.route('/admin/search/<pagination>/')
@auth.login_required
def admin_search(pagination=1):
	global limit
	search=(str(request.args['q']))#.split()
	search=search.replace(" ",'+')
	#return search
	if search=="":
		return redirect(url_for("admin_index"))
	# query_result=(Post.query.filter((Post.title).match("'%"+search+"%'"))).count()
	posts=Post.query.filter((Post.title).match("'%"+search+"%'")).all()#limit(limit).offset(int(int(int(limit)-1)*limit))
	pagin=math.ceil((Post.query.filter((Post.title).match("'%"+search+"%'")).count())/limit)
	#return str((posts))
	if math.ceil(pagin)%limit != 0:
		pagin=int(pagin+1)
	#return str(pagin)
	return render_template('admin/search.html',search=str(request.args['q']),page_name='search',posts=posts,current_pagin=int(pagination),pagin=(int(pagin)))
############## End send mail #####################
######### Personalize Email ###########
@app.route('/admin/checkemail/<email_id>/<group_id>/<action>/', methods=['POST', 'GET'])
@app.route('/admin/checkemail/<email_id>/<group_id>/<action>', methods=['POST', 'GET'])
@auth.login_required
def check_email(email_id,group_id,action):
	email_id=int(email_id)
	group_id=int(group_id)
	if action=="check":
		obj=Emailgroup.query.filter_by(email_id=email_id).filter_by(group_id=group_id)
		if obj.count()>0:
			return jsonify({'status':True })
		else:
			return jsonify({'status':False })
	elif action=="remove":
		obj=Emailgroup.query.filter_by(email_id=email_id).filter_by(group_id=group_id).first()
		Emailgroup.delete(obj)
		return jsonify({'status':'success'})
	elif action=="add":
		emailgroup = Emailgroup(email_id,group_id)
    	status = Emailgroup.add(emailgroup)
        if not status:
            return jsonify({'status':'success' })
       	else:
       		return jsonify({'status':'fail' })
#############End personalize email####################
#End Middleware
#client
@app.errorhandler(404)
def page_not_found(e):
	return render_template(template+"/404.html")
@app.route('/google58c113e5c7b23e84.html')
@app.route('/google58c113e5c7b23e84.html/')
def verify_site():
	return render_template(template+'/google58c113e5c7b23e84.html')

@app.route('/')
@app.route('/pagin/<pagination>/')
@app.route('/pagin/<pagination>')
def index(pagination=1):
	global limit
	form=ContactForm() 
	postsUpcoming = Post.query.join(UserMember).join(Category,Post.category_id == Category.id).filter(Category.slug=='upcoming-tour').order_by(Post.id.desc()).limit(3)
	postsPromotion = Post.query.join(UserMember).join(Category,Post.category_id == Category.id).filter(Category.slug=='promotion').order_by(Post.id.desc()).limit(3)
	pagin=math.ceil((Post.query.count())/limit)
	review_top = Post.query.join(Category,Post.category_id == Category.id) \
				.filter(Category.slug!='blog') \
				.filter(Category.slug!='custom-tours') \
				.filter(Category.slug!='faq') \
				.filter(Category.slug!='development-and-culture-program') \
				.filter(Category.slug!='family-trip-adventure') \
				.order_by(Post.views.desc()).limit(7)
				
	return render_template(template+'/index.html',active="home",review_top=review_top,page_name='home',postsUpcoming=postsUpcoming,postsPromotion=postsPromotion,pagin=int(pagin),current_pagin=int(pagination))


# Tours is wrong.

@app.route('/tours/<slug>')
@app.route('/tours/<slug>/')
def tours(slug = ''):

	if slug == "development-and-culture-program":
		posts = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='development-and-culture-program' ).order_by(Post.id.desc())
		categorys = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='development-and-culture-program').limit(1)
		return render_template(template+"/customTourDetail.html",posts=posts,categorys=categorys,slug=slug,page_name='customTourDetail')

	elif slug == "family-trip-adventure":
		posts = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='family-trip-adventure' ).order_by(Post.id.desc())
		categorys = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='family-trip-adventure').limit(1)
		return render_template(template+"/customTourDetail.html",posts=posts,categorys=categorys,slug=slug,page_name='customTourDetail')



@app.route('/blog/<slug>')
@app.route('/blog/<slug>/')
def blogs(slug = ''):
	posts=Post.query.filter_by(slug=slug).limit(1)
	review_top = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='blog').order_by(Post.id.desc()).limit(7)
	return render_template(template+"/singleBlog.html",posts=posts,review_top=review_top,page_name='singleBlog')


@app.route('/<slug>')
@app.route('/<slug>/')
@app.route('/<slug>/<pagination>')
@app.route('/<slug>/<pagination>/')
#can be single and category page
def single(slug='',pagination=1):

	if slug=='about':
		about = Page.query.filter_by(title='about')
		members= Member.query.all()
		return render_template(template+"/about.html",active='about-us',members=members,about=about)
	
	elif slug=='contact':
		return render_template(template+"/contact.html",active='contact-us')

	elif slug=='faq':
		posts = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='faq').order_by(Post.id.asc())
		return render_template(template+"/faq.html",active='faq',posts=posts)
		
	elif slug=='custom-tours':
		posts = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='custom-tours').order_by(Post.id.desc())
		return render_template(template+"/CustomTour.html",active='custom-tours',posts=posts)

	elif slug=='bicycle-tours':
		posts = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='bicycle-tours').order_by(Post.id.desc())
		pagin=math.ceil((Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='bicycle-tours').count())/limit)
		if(math.ceil(Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='bicycle-tours').count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template(template+"/category.html",active='bicycle-tours',posts=posts,pagin=pagin)

	elif slug=='discovery-tours':
		postsGreen = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='discovery-tours' )\
					.order_by(Post.price.asc())
		return render_template(template+"/tours.html",postsGreen=postsGreen)

	elif slug=='blog':
		review_top = Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='blog').order_by(Post.views.desc()).limit(9)
		posts=Post.query.join(Category,Post.category_id == Category.id).filter(Category.slug=='blog').order_by(Post.id.desc()).limit(9)
		return render_template(template+"/blog.html",active='blog',posts=posts,review_top=review_top,page_name='blog')

	try:
		post_object=Post.query.filter_by(slug=slug)#.limit(1)
		if post_object.count()<=0:
			page_object=Page.query.filter_by(slug=slug)#.limit(1)
		if post_object.count()>0:
			#add views count
			if session.get('amoogli_view') ==None:
				session['amoogli_view']=' '
				# return str(slug in str(session.get('amoogli_view')))
			if not slug in str(session.get('amoogli_view')):
				for post in post_object:
					old_view = post.views
					post_object.update({"views" : (old_view+1) })
					status = db.session.commit()
					session['amoogli_view'] = (str(session.get('amoogli_view')))+","+slug
		elif page_object.count()>0:
			partners=Partner.query.all()
			return render_template(template+"/page.html",partners=partners,page_name="page",page_object=page_object)
		else:
			category=Category.query.filter_by(slug=slug)
			if category.count()>0:
				cat_id=""
				category_name="None"
				category_slug=""
				for cat in category:
					cat_id=cat.id
					category_name=cat.name
					category_slug=cat.slug
				if cat_id == "":
					abort(404)
				posts=Post.query.filter_by(category_id=cat_id).order_by(Post.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
				pagin=math.ceil((Post.query.filter_by(category_id=cat_id).count())/limit)
				if(math.ceil(Post.query.filter_by(category_id=cat_id).count())%limit != 0 ):
					pagin=int(pagin+1)
				#return str(limit)
				# if category_name=='Blog':
				# 	return render_template(template+'/blog.html',page_name='category',category_slug=category_slug,category_name=category_name,posts=posts,pagin=int(pagin),current_pagin=int(pagination))
				return render_template(template+'family-trip-adventure',page_name='category',category_slug=category_slug,category_name=category_name,posts=posts,pagin=int(pagin),current_pagin=int(pagination))
			
	except Exception as e:
		return str(e.message)
		abort(404)
	cat_id=0
	post_object=Post.query.join(Category,Post.category_id == Category.id).filter(Post.slug==slug)
	for post in post_object:
		cat_id=post.category_id
	related_posts=Post.query.filter_by(category_id=cat_id).order_by(Post.id.desc()).limit(3)
	return render_template(template+'/single.html',form=form,page_name='single',related_posts=related_posts,post_object=post_object)
@app.route('/category/<slug>')
@app.route('/category/<slug>/')
@app.route('/category/<slug>/<pagination>')
@app.route('/category/<slug>/<pagination>')
def category(slug='',pagination=1):
	if slug == "promotion":
		category=Category.query.filter_by(slug=slug)
		cat_id=""
		category_name="None"
		category_slug=""
		for cat in category:
			cat_id=cat.id
			category_name=cat.name
			category_slug=cat.slug
		if cat_id == "":
			abort(404)
		posts=Post.query.filter_by(category_id=cat_id).order_by(Post.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Post.query.filter_by(category_id=cat_id).count())/limit)
		if(math.ceil(Post.query.filter_by(category_id=cat_id).count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template(template+'/category.html',page_name='category',category_slug=category_slug,category_name=category_name,posts=posts,pagin=int(pagin),current_pagin=int(pagination))	
	
	elif slug == "upcoming-tour":
		category=Category.query.filter_by(slug=slug)
		cat_id=""
		category_name="None"
		category_slug=""
		for cat in category:
			cat_id=cat.id
			category_name=cat.name
			category_slug=cat.slug
		if cat_id == "":
			abort(404)
		posts=Post.query.filter_by(category_id=cat_id).order_by(Post.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Post.query.filter_by(category_id=cat_id).count())/limit)
		if(math.ceil(Post.query.filter_by(category_id=cat_id).count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template(template+'/category.html',page_name='category',category_slug=category_slug,category_name=category_name,posts=posts,pagin=int(pagin),current_pagin=int(pagination))	
	elif slug == "blog":
		category=Category.query.filter_by(slug=slug)
		cat_id=""
		category_name="None"
		category_slug=""
		for cat in category:
			cat_id=cat.id
			category_name=cat.name
			category_slug=cat.slug
		if cat_id == "":
			abort(404)
		posts=Post.query.filter_by(category_id=cat_id).order_by(Post.id.desc()).limit(limit).offset(int(int(int(pagination)-1)*limit))
		pagin=math.ceil((Post.query.filter_by(category_id=cat_id).count())/limit)
		if(math.ceil(Post.query.filter_by(category_id=cat_id).count())%limit != 0 ):
			pagin=int(pagin+1)
		return render_template(template+'/categoryBlog.html',page_name='category',category_slug=category_slug,category_name=category_name,posts=posts,pagin=int(pagin),current_pagin=int(pagination))	
	

@app.route('/search', methods=['POST', 'GET'])
@app.route('/search/', methods=['POST', 'GET'])
def search():
	search=(str(request.args['q']))#+' '+(str(request.args['country']))#.split()
	search=search.replace(" ",'+')
	# return search
	if search=="":
		return redirect(url_for("index"))
	query_result=(Post.query.filter((Post.title).match("'%"+search+"%'"),(Post.description).match("%'"+search+"'%"))).count()
	posts=query_result=(Post.query.filter((Post.title).match("'%"+search+"%'"),(Post.description).match("%'"+search+"'%")))
	pages=(Page.query.filter((Page.title).match("'%"+search+"%'")))
	for p in pages:
		return str(p.id)
	return render_template(template+"/search.html",search=search,pages=pages,query_result=query_result,posts=posts)
# @app.route('/search', methods=['POST', 'GET'])
# @app.route('/search/', methods=['POST', 'GET'])
# def booking():
# 	return render_template(template+'/booking.html')
#end client
if __name__ == '__main__':
	 app.run(debug = True,host='0.0.0.0')
#replace white space:
#http://docs.python-requests.org/en/master/user/quickstart/