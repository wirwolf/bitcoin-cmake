
set(CONTRIB_CURRENT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
string(REGEX REPLACE "/contrib/cmake" "" CMAKE_CURRENT_SOURCE_DIR
       ${CMAKE_CURRENT_SOURCE_DIR})

set(HEADERS
    db/builder.h
    db/dbformat.h
    db/db_impl.h
    db/db_iter.h
    db/filename.h
    db/log_format.h
    db/log_reader.h
    db/log_writer.h
    db/memtable.h
    db/skiplist.h
    db/snapshot.h
    db/table_cache.h
    db/version_edit.h
    db/version_set.h
    db/write_batch_internal.h
    util/arena.h
    util/coding.h
    util/crc32c.h
    util/hash.h
    util/histogram.h
    util/logging.h
    util/mutexlock.h
    util/posix_logger.h
    util/random.h
    util/testharness.h
    util/testutil.h
    table/block_builder.h
    table/block.h
    table/filter_block.h
    table/format.h
    table/iterator_wrapper.h
    table/merger.h
    table/two_level_iterator.h
    helpers/memenv/memenv.h
    )

set(SOURCES
    db/builder.cc
    db/c.cc
    db/db_bench.cc
    db/dbformat.cc
    db/db_impl.cc
    db/db_iter.cc
    db/dumpfile.cc
    db/filename.cc
    db/leveldb_main.cc
    db/log_reader.cc
    db/log_writer.cc
    db/memtable.cc
    db/repair.cc
    db/table_cache.cc
    db/version_edit.cc
    db/version_set.cc
    db/write_batch.cc
    util/arena.cc
    util/bloom.cc
    util/cache.cc
    util/coding.cc
    util/comparator.cc
    util/crc32c.cc
    util/env.cc
    util/env_posix.cc
    util/env_win.cc
    util/filter_policy.cc
    util/hash.cc
    util/histogram.cc
    util/logging.cc
    util/options.cc
    util/status.cc
    util/testharness.cc
    util/testutil.cc
    table/block_builder.cc
    table/block.cc
    table/filter_block.cc
    table/format.cc
    table/iterator.cc
    table/merger.cc
    table/table_builder.cc
    table/table.cc
    table/two_level_iterator.cc
    helpers/memenv/memenv.cc
    )

if(UNIX OR ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    add_definitions( -DLEVELDB_PLATFORM_POSIX )
    list(APPEND SOURCES port/port_posix.cc)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    add_definitions( -DLEVELDB_PLATFORM_WINDOWS )
    list(APPEND SOURCES port/port_win.cc)
else() 
    # TODO ??:
    #	LEVELDB_PLATFORM_CHROMIUM
    message(FATAL "LevelDB: Unknown Build System.  Aborting.")
endif()

# TODO:
#add_definitions(
	#-DTARGET_OS=OS_WINDOWS_CROSSCOMPILE
	#-DTARGET_OS=Darwin

set(DIR_SOURCES)
foreach(file ${SOURCES})
    set(DIR_SOURCES ${DIR_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/${file})
endforeach()

set(DIR_HEADERS)
foreach(file ${HEADERS})
    set(DIR_HEADERS ${DIR_HEADERS} ${CMAKE_CURRENT_SOURCE_DIR}/${file})
endforeach()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

add_library(leveldb STATIC ${DIR_HEADERS} ${DIR_SOURCES})

# Leftover from previous glob() usage in case we switch back:
#
#file(GLOB HEADERS db/*.h util/*.h table/*.h helpers/memenv/*.h)
#file(GLOB SOURCES db/*.cc util/*.cc table/*.cc helpers/memenv/*.cc)
#
# Remove unit tests and main functions from lib:
#foreach(SOURCE ${SOURCES})
#    if(SOURCE MATCHES "(.*)_test.cc")
#        list(REMOVE_ITEM SOURCES ${SOURCE})
#    elseif(SOURCE MATCHES "(.*)_main.cc")
#        list(REMOVE_ITEM SOURCES ${SOURCE})
#    endif()
#endforeach()


