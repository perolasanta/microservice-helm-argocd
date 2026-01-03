from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def home():
    return "🚀 Deployed with Helm + ArgoCD!"
    
@app.route('/health')
def health():
    return jsonify({'status': 'healthy'}), 200
    
@app.route('/api/test')
def test():
    return jsonify({'test': 'This is a test endpoint'}), 200


if __name__ == "__main__":
# Use 0.0.0.0 to make it accessible outside container
    print("Starting Flask app on port 5000...")
    print("Available routes:")
    for rule in app.url_map.iter_rules():
        print(f"  {rule}")
    app.run(host='0.0.0.0', port=5000, debug=False)
