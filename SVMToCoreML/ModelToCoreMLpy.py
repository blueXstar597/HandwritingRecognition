# Author: Gael Varoquaux <gael dot varoquaux at normalesup dot org>
# License: BSD 3 clause

import numpy as np
import matplotlib.pyplot as plt
import pickle

from sklearn import datasets, svm,metrics


digits = datasets.load_digits()
samples = len (digits['images'])
classifier = svm.SVC (gamma=0.001)
data = digits['images'].reshape((samples,-1))
classifier.fit(data[:samples // 2], digits ['target'][:samples // 2])

with open('mymodel.pkl', 'wb') as file:
    pickle.dump(classifier, file, protocol=2)

# Now predict the value of the digit on the second half:
expected = digits['target'] [samples // 2:]
predicted = classifier.predict(data[samples // 2:])

print("Classification report for classifier %s:\n%s\n"
      % (classifier, metrics.classification_report(expected, predicted)))
print("Confusion matrix:\n%s" % metrics.confusion_matrix(expected, predicted))
#flatten the image,converting from data -> matrix

