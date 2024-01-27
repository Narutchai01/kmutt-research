import ImageProfile from "./ImageProfile"
import PropTypes from "prop-types"

type UserData = {
    imageURL: string;
    name: string;
};

const TitleProfile = ({ userData }: { userData: UserData }) => {
    return (
        <div className="grid grid-cols-[1fr_4fr] items-center w-full justify-center">
            <ImageProfile ImageURL={userData.imageURL} />
            <h1>{userData.name}</h1>
        </div>
    );
};

TitleProfile.propTypes = {
    userData: PropTypes.shape({
        imageURL: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
    }).isRequired,
};

export default TitleProfile;
