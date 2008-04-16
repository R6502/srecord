//
//      srecord - manipulate eprom load files
//      Copyright (C) 1998, 1999, 2001, 2002, 2005-2008 Peter Miller
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; either version 3 of the License, or
//      (at your option) any later version.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program. If not, see
//      <http://www.gnu.org/licenses/>.
//

#ifndef INCLUDE_SREC_INPUT_FILTER_CHECKSUM_H
#define INCLUDE_SREC_INPUT_FILTER_CHECKSUM_H


#include <lib/endian.h>
#include <lib/interval.h>
#include <lib/srec/input/filter.h>
#include <lib/srec/record.h>

/**
  * The srec_input_filter_checksum class is an abstraction of various
  * checksums to be ammplied to input sources.
  */
class srec_input_filter_checksum:
    public srec_input_filter
{
public:
    /**
      * The destructor.
      */
    virtual ~srec_input_filter_checksum();

protected:
    // See bas class for documentation.
    bool read(srec_record &record);

    /**
      * The constructor.
      * May only be called by derived classes.
      *
      * @param deeper
      *     The deeper input source being checksummed.
      * @param address
      *     The address to place the checksum.
      * @param length
      *     The number of bytes of checksum to be placed into the result.
      * @param end
      *     The byte order
      * @param width
      *     The width of the values being summed.  Usually 1 byte, but
      *     wider combinations are possible.  If you use something
      *     wider, it is assumed that they are alligned on multiples of
      *     that width, no provision for an offset is provided.
      */
    srec_input_filter_checksum(srec_input::pointer deeper, int address,
        int length, endian_t end, int width = 1);

    typedef unsigned long sum_t;

    /**
      * The checksum_address instance variable is used to remember where
      * to place the checksum at the end of the data.
      */
    int checksum_address;

    /**
      * The length instance variable is used to remember how many bytes
      * of checksum are to be emitted.
      */
    int length;

    /**
      * The end instance variable is used to remember whether the
      * summation for the checksum is bigendian or little endian.
      */
    endian_t end;

    /**
      * The sum instance variable is used to remember the running
      * checksum of the incoming data source.
      */
    sum_t sum;

    /**
      * The width instance variable is used to remember the swathe width
      * as the incming bytes are added to the running sum.
      */
    int width;

    /**
      * The calculate method is used to calculate the checksum to be
      * written into the output, based on the "sum" instance variable.
      */
    virtual sum_t calculate() = 0;

    /**
      * The generate method is used to generate the final data record,
      * once all of the deeper input has been passed through, based on
      * the calculated checksum.
      *
      * @param record
      *     Where to place the returned data.
      * @returns
      *     bool; false if end-of-file, true if data available
      */
    bool generate(srec_record &record);

private:
    /**
      * The default constructor.  Do not use.
      */
    srec_input_filter_checksum();

    /**
      * The copy constructor.  Do not use.
      */
    srec_input_filter_checksum(const srec_input_filter_checksum &);

    /**
      * The assignment operator.  Do not use.
      */
    srec_input_filter_checksum &operator=(const srec_input_filter_checksum &);
};

#endif // INCLUDE_SREC_INPUT_FILTER_CHECKSUM_H
