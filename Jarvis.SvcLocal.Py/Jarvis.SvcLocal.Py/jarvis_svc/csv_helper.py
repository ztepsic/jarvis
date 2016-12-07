import csv
import os.path
import glob
import shutil
import re
from datetime import datetime, timedelta


class CsvHelper(object):
    """Csv helper class"""

    FILENAME_MASK = "sensor_readings_{}_{}.csv"

    def __init__(self, arg):
        super(CsvHelper, self).__init__()
        self.arg = arg

    @staticmethod
    def generate_filename():
        """Generates csv filename based on mask"""

        dt = datetime.now()
        start = dt - timedelta(days=dt.weekday())
        end = start + timedelta(days=6)

        return CsvHelper.FILENAME_MASK.format(start.strftime('%Y%m%d'), end.strftime('%Y%m%d'))


    @staticmethod
    def write_to_csv(csv_filename, fieldnames_header, data):
        """Writes data to csv file"""

        isfile = os.path.isfile(csv_filename)

        with open(csv_filename, "a") as csv_file:
                csv_writer = csv.DictWriter(csv_file, fieldnames = fieldnames_header, dialect = "unix", delimiter = ";", quotechar = "|", quoting = csv.QUOTE_MINIMAL)
                if(not isfile):
                    csv_writer.writeheader()
                # csv_writer.writerow({'first_name': 'Baked', 'last_name': 'Beans'})

                csv_writer.writerows(data)

    @staticmethod
    def list_csv_files_in(source_path = ""):
        """List CSV files in given source path"""

        file_path_mask = os.path.join(source_path, CsvHelper.FILENAME_MASK.format("*", "*"))
        csv_files = glob.glob(file_path_mask)
        csv_files.sort()
        
        return csv_files


    @staticmethod
    def archive_csv(csv_file_path, target_path):
        """Archives CSV file by moving file to provided location"""
        isfile = os.path.isfile(csv_file_path)
        if(isfile):
            regex_pattern = re.compile("\.csv")
            filename = os.path.basename(csv_file_path)
            for m in regex_pattern.finditer(filename):
                position = m.start()
                break

            new_filename = filename[:position] + "_a" + datetime.now().strftime("%Y%m%d%H%M%S") + filename[position:]
            new_file_path= os.path.join(target_path)

            shutil.move(csv_file_path, new_file_path)