import PropType from "prop-types";

type ImageProfileProps = {
  ImageURL: string;
};

const ImageProfile: React.FC<ImageProfileProps> = ({ ImageURL }) => {
  return(
    <>
        <img src={ImageURL} alt="Profile" className="rounded-full h-10 w-10 flex items-center justify-center" />
    </>
  );
};

ImageProfile.propTypes = {
  ImageURL: PropType.string.isRequired,
};

export default ImageProfile;
