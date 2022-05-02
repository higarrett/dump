#!/bin/bash

sudo systemctl daemon-reload
sudo systemctl enable fake3_.service
sudo systemctl restart fake3_.service

sudo systemctl enable fake3_1.service
sudo systemctl restart fake3_1.service

sudo systemctl enable fake3_2.service
sudo systemctl restart fake3_2.service

sudo systemctl enable fake3_3.service
sudo systemctl restart fake3_3.service

sudo systemctl enable fake3_4.service
sudo systemctl restart fake3_4.service

sudo systemctl enable fake3_5.service
sudo systemctl restart fake3_5.service

sudo systemctl enable fake3_6.service
sudo systemctl restart fake3_6.service

sudo systemctl enable fake3_7.service
sudo systemctl restart fake3_7.service

sudo systemctl enable fake3_8.service
sudo systemctl restart fake3_8.service

sudo systemctl enable fake3_9.service
sudo systemctl restart fake3_9.service
