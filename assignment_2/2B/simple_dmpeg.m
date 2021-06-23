%
% A SIMPLE MPEG LIKE DECODING OF SEQUENTIAL IMAGERY
%
% current_image - current uint8 image to encode
% reference_image - image to compare to to determine which 8x8 regions need
%                   updating. If empty then encode the entire image.
% Q - quality factor to employ in compression
%
% huff_encoded - Huffman encoded data (created by Huff06.m)
% updated_reference - updated reference image.
%

function new_image = simple_dmpeg(huff_encoded,previous_image,Q)

if (nargin<3)
  Q=80;
end

% decode the Huffman encoded jpeg coefficients
huff_decoded = Huff06( double(huff_encoded) );
dc_coeffs = reshape(huff_decoded{1}, size(previous_image)/8);
ac_coeffs = reshape(huff_decoded{2}, [ 63 prod(size(previous_image)/8)]);

% by default new output image is old (plus any changes made later)
new_image = previous_image;

%-----------change code from here --------------------------------

tile_num=0;
% ANALYSE (AND COMPRESS?) EACH 8x8 BLOCK IN THE IMAGE IN TURN
% FOR LOOPS
for ii = 1:8:size(new_image,1)
    for jj = 1:8:size(new_image,2)
      tile_num = tile_num+1;
      % 1. retrieve coefficients for this block
      dc_iijj = dc_coeffs((ii+7)/8, (jj+7)/8);
      
      % 2. retrieve coefficients for this block
      ac_iijj = ac_coeffs(:,tile_num);
      
      % 3. determine if block needs updating / decoding
      if (dc_iijj ~= 0 || any(ac_iijj))
        % 4. extract out the decompressed tile (if required)
        new_image(ii:ii+7, jj:jj+7) = djpeg_8x8(dc_iijj, ac_iijj, Q);
      end
    end
end
%
% SEE SIMPLE_MPEG for clues.

%-----------change code above here --------------------------------

% enforce uint8 format
new_image = uint8(new_image);

return

end

% -------------------------------------------------------------------------



  

