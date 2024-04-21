# app/routes.py
import ast
from flask import abort, render_template
from flask import request, jsonify
from .db import get_db
from werkzeug.security import check_password_hash
from flask import render_template, request, flash, redirect, url_for, session

def init_routes(app):
    @app.route('/')
    def home():
        db = get_db()
        #cursor = db.execute('SELECT * FROM cars WHERE featured = 1')
        cursor = db.execute('SELECT * FROM Listings WHERE status = "Active"')
        #cursor = db.execute('SELECT * FROM Listings')
        #featured_cars = [dict(car) for car in cursor.fetchall()]
        listings = [dict(listing) for listing in cursor.fetchall()]
        print(listings)
        #for car in featured_cars:
        #    lst = ast.literal_eval(car["body_styles"])
        #    car['body_styles']=','.join(lst)
        #    image = lst[0].replace('"', '').replace("'", "").lower().replace("/", "_")
        #    car['image'] = '../static/img/car_automobile_' + image + '.svg'
        #for cars in featured_cars:
        #    print(f"{cars['id']} {cars['make']} {cars['model']}")
        return render_template('home.html', flistings=listings)

    @app.route('/about')
    def about():
        return render_template('about.html')




    @app.route('/book-test-drive/<int:item_id>')
    def book_test_drive(item_id):
        db = get_db()
        item = db.execute('SELECT * FROM items WHERE id = ?', (item_id,)).fetchone()
        if item is None:
            abort(404)
        print(f"{item['id']} {item['make']} {item['model']}")
        return render_template('book_test_drive.html', item_id={item['id']}, item=item)
    

    @app.route('/api/update_contacts', methods=['POST'])
    def update_contacts():
        data = request.json
        db = get_db()
        try:
            cursor = db.cursor()
            cursor.execute("""
                           INSERT INTO contacts (item_id, name, email, phone, message) VALUES (?, ?, ?, ?, ?)""", (data['item_id'], data['name'], data['email'], data['phone'], data['message']))
            db.commit()
            return jsonify({'success': True, 'message': 'Contact information added successfully!'}), 200
        except Exception as e:
            print("log : ",e)
            db.rollback()
        return jsonify({'success': False, 'message': 'Failed to add contact information. Error: ' + str(e)}), 500
    
    
    @app.route('/admin')
    def admin():
        db = get_db()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM contacts')
        contacts = cursor.fetchall()
        for contact in contacts:
            print(f"{contact['id']} {contact['name']}")
        return render_template('admin.html', contacts=contacts)


    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            try:
                db = get_db()
                cursor = db.cursor()
                cursor.execute('SELECT * FROM user WHERE username = ?', (username,))
                user = cursor.fetchone()
                print(f"{user['id']} {user['username']}")
                
                if user and user['password_hash'] == password:
                    # Login successful, redirect to admin page
                    return redirect(url_for('admin'))
                else:
                    # Login failed
                    flash('Invalid username or password')
                db.rollback()
            except Exception as e:
                print("log : ",e)
        return render_template('login.html')

    @app.route('/inventory')
    def inventory():
        start = request.args.get('start', 0, type=int)
        db = get_db()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM items ORDER BY id LIMIT 15 OFFSET ?', (start,))
        items = [dict(item) for item in cursor.fetchall()]
        for item in items:
            lst = ast.literal_eval(item["body_styles"])
            item['body_styles']=','.join(lst)
            image = lst[0].replace('"', '').replace("'", "").lower().replace("/", "_")
            item['image'] = '../static/img/item_automobile_' + image + '.svg'
        return render_template('inventory.html', items=items)

    @app.route('/inventory/items')
    def inventory_items():
        start = request.args.get('start', 0, type=int)
        db = get_db()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM items ORDER BY id LIMIT 15 OFFSET ?', (start,))
        items = [dict(item) for item in cursor.fetchall()]
        for item in items:
            lst = ast.literal_eval(item["body_styles"])
            item['body_styles']=','.join(lst)
            image = lst[0].replace('"', '').replace("'", "").lower().replace("/", "_")
            item['image'] = '../static/img/item_automobile_' + image + '.svg'
        return jsonify(items=[dict(item) for item in items])

    @app.route('/items/<int:item_id>')
    def item_details(item_id):
        db = get_db()
        item = dict(db.execute('SELECT * FROM items WHERE id = ?', (item_id,)).fetchone())
        if item is None:
            abort(404)
        lst = ast.literal_eval(item["body_styles"])
        item['body_styles']=','.join(lst)
        image = lst[0].replace('"', '').replace("'", "").lower().replace("/", "_")
        item['image'] = '../static/img/item_automobile_' + image + '.svg'
        return render_template('item_details.html', item=dict(item))


