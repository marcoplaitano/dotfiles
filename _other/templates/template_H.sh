#!/bin/bash


file=$1
name=$2


echo $"\
/**
 * @file $(basename "$file")
 * @author Marco Plaitano
 * @date $(date +'%d %b %Y')
 */

#ifndef ${name^^}_H
#define ${name^^}_H

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>



#endif /* ${name^^}_H */" > "$file"
