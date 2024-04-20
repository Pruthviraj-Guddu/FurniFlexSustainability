## Sewa
## Jilu James
## Pruthviraj Mundargi pm935@drexel.edu



# run.py

from app import create_app

app = create_app()

if __name__ == '__main__':
    print("log:hello app started")
    app.run(host='localhost', port=8080, debug=True)

