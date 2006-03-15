//
//	srecord - manipulate eprom load files
//	Copyright (C) 1998, 1999, 2001, 2002, 2005, 2006 Peter Miller;
//	All rights reserved.
//
//	This program is free software; you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation; either version 2 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program; if not, write to the Free Software
//	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.
//
// MANIFEST: interface definition for lib/srec/output/file/srecord.cc
//

#ifndef INCLUDE_SREC_OUTPUT_FILE_SRECORD_H
#define INCLUDE_SREC_OUTPUT_FILE_SRECORD_H

#pragma interface "srec_output_file_srecord"

#include <srec/output/file.h>

/**
  * The srec_output_file_srecord class is used to represent an output
  * file which emits Motorola S-Record format.
  */
class srec_output_file_srecord:
    public srec_output_file
{
public:
    /**
      * The destructor.
      */
    virtual ~srec_output_file_srecord();

    /**
      * The default constructor.
      * The output will be written to the standard output.
      */
    srec_output_file_srecord();

    /**
      * The constructor.
      *
      * @param filename
      *     The file name to open to write data to.  The name "-" is
      *     understood to mean the standard output.
      */
    srec_output_file_srecord(const char *filename);

    // See base class for documentation.
    void write(const srec_record &);

    // See base class for documentation.
    virtual void line_length_set(int);

    // See base class for documentation.
    virtual void address_length_set(int);

    // See base class for documentation.
    virtual int preferred_block_size_get() const;

    // See base class for documentation.
    void command_line(srec_arglex *cmdln);

private:
    /**
      * The data_count instance variable is used to remember the total
      * number of ouput data lines have occurred to date.  Ths is used
      * at the end of the file to emit an S5 record.
      */
    unsigned long data_count;

    /**
      * The pref_block_size instance variable is used to remember the
      * preferred number of data bytes (NOT encoded hex characters) to
      * be placed in each output line.
      */
    int pref_block_size;

    /**
      * The address_length instance variable is used to remember the
      * minimum number of address bytes to be emitted into output lines.
      */
    int address_length;

    /**
      * The address_shift method is used to remember how far to the left
      * addresses need to be shifted to become byte addresses.
      * The default is zero (0).
      *
      * This is because of some poorly though out "extentions" to this
      * file format, for 16-bit and 32-bit data busses.  I say "poory
      * thought out" because the no way (zero, zip, nada) of discovering
      * this just by looking at the data.
      */
    int address_shift;

    /**
      * The data_count_written instance variable is used to remember
      * whether or not we have written out the data count record.
      * Usually this is done with the start arrdess record, but there
      * are circumstances where it will be needed when the file is
      * closed.
      */
    bool data_count_written;

    /**
      * The write_data_count method is used to write out a data count
      * record, if one is required.
      */
    void write_data_count();

    /**
      * The write_inner method is used to write a line of output.
      *
      * @param tag
      *     The tag value at the start of the line.  For example, and S1
      *     line would have a tag of 1.
      * @param address
      *     The address of the first byte of data on the line.
      * @param address_nbytes
      *     The number of bytes of address to emit.
      * @param data
      *     The palyload of this line.
      * @param data_nbytes
      *     The number of bytes of payload.
      */
    void write_inner(int tag, unsigned long address, int address_nbytes,
        const void *data, int data_nbytes);

    /**
      * The copy constructor.  Do not use.
      */
    srec_output_file_srecord(const srec_output_file_srecord &);

    /**
      * The assignment operator.  Do not use.
      */
    srec_output_file_srecord &operator=(const srec_output_file_srecord &);
};

#endif // INCLUDE_SREC_OUTPUT_FILE_SRECORD_H
