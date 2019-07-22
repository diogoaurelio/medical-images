# Medical Images
Repository for project involving DL with High Resolution Microscopy Images (Whole-Slide Images).

## Background

Tomita et.al 2018 explain clearly the challenge: 
"In the field of pathology, tissue slides are scanned as high
resolution images, which can have sizes up to 10,000 ×
10,000 pixels. This high resolution is necessary because
each whole slide contains thousands of cells, for which the
cellular structures must be visible in order to identify
regions of the tissue that indicate disease (lesions).
However, the size of lesions is often relatively small,
typically around 100 × 100 pixels, as most of the cells in a
given slide are normal. Therefore, the decisive regions of
interest containing lesions usually comprise much less than
one percent of the tissue area."

Useful tips:

* For preprocessing, we removed white background on the
  slides and extracted only regions of the images that contain
  tissue. (Tomita et.al 2018). See example [here](https://github.com/BMIRDS/deepslide/blob/master/code/utils_processing.py)


## Installation
Setup your python environment. For linux/mac:

```bash
make venv
```

Or perform the equivalent commands:
```
git clone https://github.com/diogoaurelio/medical-images.git .
cd medical-images
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -e .
```


To use the OpenSlide Python interface to view whole slide images, we are using a script provided in openslide-python repo to use the DeepZoom deepzoom_multiserver.py script.
```bash
git clone https://github.com/openslide/openslide-python.git
```

Since we already have copied this script:
```bash
# install dependencies
sudo apt-get install openslide-tools
sudo apt-get install python-openslide

make py_update
source venv/bin/activate
python openslide/deepzoom_multiserver.py -Q 100 ./data/
```

This approach was taken from [IBM blog post Whole-slide image processing in python](https://developer.ibm.com/articles/an-automatic-method-to-identify-tissues-from-big-whole-slide-images-pt1/).

## Reference sources

Here is a collection of materials (blog articles, papers, code repositories, forum threads, etc.) that I found helpful while working on this project:

* [IBM blog post Whole-slide image processing in python](https://developer.ibm.com/articles/an-automatic-method-to-identify-tissues-from-big-whole-slide-images-pt1/)
* [Classification of Histopathology Images with Deep Learning: A Practical Guide - from Jason Wei](https://medium.com/health-data-science/classification-of-histopathology-images-with-deep-learning-a-practical-guide-2e3ffd6d59c5)
* [Attention based classification](https://arxiv.org/abs/1811.08513)

