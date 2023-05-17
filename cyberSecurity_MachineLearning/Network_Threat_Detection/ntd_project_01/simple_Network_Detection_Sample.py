import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from sklearn.preprocessing import LabelEncoder

# Load the data
# url = 'http://kdd.ics.uci.edu/databases/kddcup99/kddcup.data.gz'
# data = pd.read_csv(url, header=None)
# file_path = '/path/to/your/downloaded/file/kddcup.data.gz'

file_path = './network_data.csv'
data = pd.read_csv(file_path, header=None)

# Define column names for DataFrame (based on KDD Cup '99 dataset description)
columns = ["duration","protocol_type","service","flag","src_bytes","dst_bytes","land","wrong_fragment","urgent","hot","num_failed_logins","logged_in",
           "num_compromised","root_shell","su_attempted","num_root","num_file_creations","num_shells","num_access_files","num_outbound_cmds",
           "is_host_login","is_guest_login","count","srv_count","serror_rate","srv_serror_rate","rerror_rate","srv_rerror_rate","same_srv_rate",
           "diff_srv_rate","srv_diff_host_rate","dst_host_count","dst_host_srv_count","dst_host_same_srv_rate","dst_host_diff_srv_rate",
           "dst_host_same_src_port_rate","dst_host_srv_diff_host_rate","dst_host_serror_rate","dst_host_srv_serror_rate","dst_host_rerror_rate",
           "dst_host_srv_rerror_rate","label"]

data.columns = columns

# Preprocess the data
# Convert categorical features to numerical
categorical_columns = ['protocol_type', 'service', 'flag']
data_encoded = pd.get_dummies(data, columns=categorical_columns)

# Map 'label' to a binary classification: 'normal.' or 'anomalous'
data_encoded['label'] = data_encoded['label'].map(lambda x: 0 if x == 'normal.' else 1)

# Split data into features and target variable
X = data_encoded.drop('label', axis=1)
y = data_encoded['label']

# Split data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
clf = RandomForestClassifier(n_estimators=10, random_state=42)
clf.fit(X_train, y_train)

# Use model to make predictions on the test set
y_pred = clf.predict(X_test)

# Classification report
print(classification_report(y_test, y_pred))

