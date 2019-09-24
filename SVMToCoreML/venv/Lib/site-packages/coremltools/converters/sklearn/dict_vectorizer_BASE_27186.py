import _sklearn_util
from ...__init__ import SPECIFICATION_VERSION, INTERNAL_SPECIFICATION_VERSION 
from ..._internal_utils import set_transform_interface_params as \
                                       _set_transform_interface_params
                                       
from ...proto import Model_pb2 as _Model_pb2
from ...proto import FeatureTypes_pb2 as _FeatureTypes_pb2
from ..._feature_management import process_or_validate_features
from ..._feature_management import create_feature_vectorizer

from sklearn.feature_extraction import DictVectorizer
from ... import _datatypes
from ...import pipeline as _pipeline

model_type = 'transformer'
sklearn_class = DictVectorizer

def convert(model, input_features, output_features):
    """Convert a imputer model to the protobuf spec.

    Parameters
    ----------
    model: Imputer
        A trained Imputer model.

    input_name: str
        Name of the input column.

    output_name: str
        Name of the output column.

    input_type: type
        Type of the input column

    Returns
    -------
    model_spec: An object of type Model_pb.
        Protobuf representation of the model
    """

    _INTERMEDIATE_FEATURE_NAME = "__sparse_vector_features__"

    n_dimensions = len(model.feature_names_)
    input_features = process_or_validate_features(input_features)

    # Make sure the input features are good. 
    assert len(input_features) == 1
    assert isinstance(input_features[0][1], _datatypes.Dictionary)

    # Ensure that the output_features are also solid.
    output_features = process_or_validate_features(output_features, n_dimensions)

    # The DictVectorizer in the framework outputs a sparse dictionary 
    # of index to value due to other considerations, but we are expecting 
    # the output of this to be a dense feature vector.  To make that happen, 
    # put a feature_vectorizer immediately after the dict vectorizer.
    pline = _pipeline.Pipeline(input_features, output_features)

    # Set the basic model parameters of the dict vectorizer component.
    dv_spec = _Model_pb2.Model()
    dv_spec.specificationVersion = SPECIFICATION_VERSION
    dv_spec.internalSpecificationVersion = INTERNAL_SPECIFICATION_VERSION

    # Set up the dict vectorizer parameters
    tr_spec = dv_spec.dictVectorizer
    for feature_name in model.feature_names_:
        tr_spec.stringToIndex.vector.append(feature_name)


    intermediate_features = [(_INTERMEDIATE_FEATURE_NAME, 
        _datatypes.Dictionary(key_type = int))]

    # Set the interface for the dict vectorizer with the input and the 
    # intermediate output
    _set_transform_interface_params(
            dv_spec, input_features, intermediate_features)

    pline.add_model(dv_spec)

    # Follow the dict vectorizer by a feature_vectorizer to change the sparse 
    # output layer into a dense vector as expected.
    fvec, _num_out_dim = create_feature_vectorizer(intermediate_features,
            output_features[0][0], {"__sparse_vector_features__" : n_dimensions})

    pline.add_model(fvec) 

    return pline.spec

def update_dimension(m): 
    return len(m.feature_names_)

def get_input_dimension(m):
    return None

def get_input_feature_names(m): 
    return m.feature_names_
