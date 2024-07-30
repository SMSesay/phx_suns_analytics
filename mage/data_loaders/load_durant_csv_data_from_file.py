from mage_ai.io.file import FileIO
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
import os
import pandas as pd


@data_loader
def load_data_from_file(*args, **kwargs):
    """
    Template for loading data from filesystem.
    Load data from 1 file or multiple file directories.

    For multiple directories, use the following:
        FileIO().load(file_directories=['dir_1', 'dir_2'])

    Docs: https://docs.mage.ai/design/data-loading#fileio
    """
    filepath = 'data/kd_shots_24.csv'

    return FileIO().load(filepath, 'csv', index_col=[0])


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

@test
def test_instance(output, *args) -> None:
    """
    """
    assert isinstance(output, pd.DataFrame), 'The output is not a DataFrame'

@test
def test_length(output, *args) -> None:
    """
    """
    assert len(output.index >= 2), 'The output has more than 1 row'