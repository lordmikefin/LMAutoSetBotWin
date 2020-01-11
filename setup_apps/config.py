# -*- coding: UTF-8 -*-
"""
    config.py
    ~~~~~~~~~

    XML configuration file handler.

    License of this script file:
       MIT License

    License is available online:
      https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE

    Latest version of this script file:
      https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_apps/config.py


    :copyright: (c) 2020, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
    :license: MIT License
"""

import xml.etree.ElementTree as ET

# https://stackabuse.com/reading-and-writing-xml-files-in-python/

def create_test_xml():
    # create the file structure
    print('create the XML file structure')
    xml_config = ET.Element('test_element')
    items = ET.SubElement(xml_config, 'items')
    item1 = ET.SubElement(items, 'item')
    item2 = ET.SubElement(items, 'item')
    item1.set('name','item1')
    item2.set('name','item2')
    item1.text = 'item1abc'
    item2.text = 'item2abc'

    # create a new XML file with the results
    print('create a new XML file with the results')
    mydata = str(ET.tostring(xml_config),'utf-8')
    print('mydata type: ' + str(type(mydata)))
    myfile = open("xml_config.xml", "w")
    myfile.write(mydata)
    myfile.close()
