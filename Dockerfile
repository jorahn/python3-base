FROM python:3.5

ENV HOME /root

RUN apt-get update && apt-get -yq install gcc build-essential gfortran g++ zlib1g-dev libatlas-base-dev wget

# Build HDF5
RUN cd ; wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz
RUN cd ; tar zxf hdf5-1.10.1.tar.gz
RUN cd ; mv hdf5-1.10.1 hdf5-setup
#RUN cd ; wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8.17/src/hdf5-1.8.17.tar.gz
#RUN cd ; tar zxf hdf5-1.8.17.tar.gz
#RUN cd ; mv hdf5-1.8.17 hdf5-setup
RUN cd ; cd hdf5-setup ; ./configure --prefix=/usr/local/
RUN cd ; cd hdf5-setup ; make && make install

# cleanup
RUN cd ; rm -rf hdf5-setup
RUN apt-get -yq autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install numpy
RUN pip install pandas
RUN pip install bottleneck
RUN pip install numexpr
RUN pip install tables
RUN pip install scipy
RUN pip install scikit-learn
RUN pip install "ipython[notebook]"
