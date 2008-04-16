//
//      srecord - manipulate eprom load files
//      Copyright (C) 2000-2002, 2005-2008 Peter Miller
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

#ifndef INCLUDE_SREC_INPUT_FILTER_CHECKSUM_BITNOT_H
#define INCLUDE_SREC_INPUT_FILTER_CHECKSUM_BITNOT_H

#include <lib/srec/input/filter/checksum.h>

/**
  * The srec_input_filter_checksum_bitnot class is used to represent the
  * state of a checksum filter that inserts a bitnot sum into the data.
  */
class srec_input_filter_checksum_bitnot:
    public srec_input_filter_checksum
{
public:
    /**
      * The destructor.
      */
    virtual ~srec_input_filter_checksum_bitnot();

private:
    /**
      * The constructor.
      *
      * @param deeper
      *     The deeper input source being checksummed.
      * @param address
      *     The address to place the checksum.
      * @param length
      *     The number of bytes of checksum to be placed into the result.
      * @param end
      *     The byte order.
      * @param width
      *     The width of the values being summed.  Usually 1 byte, but
      *     wider combinations are possible.  If you use something
      *     wider, it is assumed that they are alligned on multiples of
      *     that width, no provision for an offset is provided.
      */
    srec_input_filter_checksum_bitnot(srec_input::pointer deeper, int address,
        int length, endian_t end, int width = 1);

public:
    /**
      * The create class method is used to create new dynamically
      * allocated instances of this class.
      *
      * @param deeper
      *     The incoming data source to be filtered
      * @param address
      *     The address to place the checksum.
      * @param length
      *     The number of bytes of checksum to be placed into the result.
      * @param end
      *     The byte order.
      * @param width
      *     The width of the values being summed.  Usually 1 byte, but
      *     wider combinations are possible.  If you use something
      *     wider, it is assumed that they are alligned on multiples of
      *     that width, no provision for an offset is provided.
      */
    static pointer create(const srec_input::pointer &deeper, int address,
        int length, endian_t end, int width = 1);

protected:
    // See base class for documentation.
    sum_t calculate();

private:

    /**
      * The default constructor.  Do not use.
      */
    srec_input_filter_checksum_bitnot();

    /**
      * The copy constructor.  Do not use.
      */
    srec_input_filter_checksum_bitnot(
        const srec_input_filter_checksum_bitnot &);

    /**
      * The assignment operator.  Do not use.
      */
    srec_input_filter_checksum_bitnot &operator=(
            const srec_input_filter_checksum_bitnot &);
};

#endif // INCLUDE_SREC_INPUT_FILTER_CHECKSUM_BITNOT_H
