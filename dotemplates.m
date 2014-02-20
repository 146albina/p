#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

using namespace std;
using namespace cv;

vector<int> read_template(Mat image, int x, int y)
{
	std::vector<int> temp;
	for (int i = 0; i < 9; ++i)
	{
		for (int j = 0; j < 9; ++j)
		{
			temp(x,y) = image.at(x-4+i,y-4+i);
		}
	}
}



int main(int argc, char const *argv[])
{
	Mat image_origin, eye, mask, manual;
	Mat channel_im[3], channel_mask[3];
	int temp_template [81];
	int number = 21;
	int columns, rows;
	int i, j;
	// read images
	char filenum[100];
	sprintf(filenum,"./DRIVE/training/images/%d_training.tif",number);
	image_origin = imread(string(filenum));
	// mask = imread("DRIVE/training/mask/" + itoa(number) + "_training_mask.gif", 0);
	// manual = imread("DRIVE/training/1st_manual/" + itoa(number) + "_manual.gif", 0);
	Mat skel = imread("skeleton.jpg");
	// how many non-zero (white) pixels in skeleton = number of templates
	int num_templates = countNonZero(skel);

	//cout << image.at<Vec3b>(250,200)[1] << "\n cols: " << image.cols << "\n rows: " << image.rows << "\n";
	// get green channel
	split(image_origin, channel_im);
	eye = channel_im[1];
	// number of rows and columns of the image
	columns = eye.cols;
	rows = eye.rows;


	for (int i = 0; i < rows; ++i)
	{
		for (int j = 0; j < columns; ++j)
		{
			if (eye.at(i,j) == 255)
				temp_template = read_template(eye,i,j);
			else eye.at(i,j) =0;
		}
	}

	return 0;
}
