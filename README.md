# Dockerfile for image `rcsa/python3-base`

## Ingredients:

- Python 3.5 (linked to update with official image)
- HDF5 (quite cumbersome to install from source)
- PyTables (requires HDF5 installed)
- NumPy (compiling takes some time)
- Pandas (requires pytables for hdf5-files and compiling takes some time)
- SciPy, Scikit-Learn (quite cumbersome to install from source)

All taken care of...

## Build on top of this image with a Dockerfile like this:

    FROM rcsa/python3-base:latest
    ENV PYTHONUNBUFFERED 1
    RUN mkdir /code
    WORKDIR /code
    ADD requirements.txt /code/
    RUN pip install -r requirements.txt
    ADD . /code/
    CMD ["python", "run.py"]

## and app.py like this (see [here](http://pandas.pydata.org/pandas-docs/stable/io.html#io-hdf5)):

    import pandas as pd
    #persist dataframe
    with pd.HDFStore('file.h5') as store:
        store['key'] = pd.DataFrame()
    #load dataframe
    with pd.HDFStore('file.h5') as store:
        df = store['key']
