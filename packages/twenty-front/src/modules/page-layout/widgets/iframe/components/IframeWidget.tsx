import { useIsPageLayoutInEditMode } from '@/page-layout/hooks/useIsPageLayoutInEditMode';
import { type PageLayoutWidget } from '@/page-layout/types/PageLayoutWidget';
import { PageLayoutWidgetNoDataDisplay } from '@/page-layout/widgets/components/PageLayoutWidgetNoDataDisplay';
import { WidgetSkeletonLoader } from '@/page-layout/widgets/components/WidgetSkeletonLoader';
import { styled } from '@linaria/react';
import { useState } from 'react';
import { useParams } from 'react-router-dom';
import { getSafeUrl, isDefined } from 'twenty-shared/utils';
import { themeCssVariables } from 'twenty-ui/theme-constants';

const StyledContainer = styled.div<{ $isEditMode: boolean }>`
  background: ${themeCssVariables.background.primary};
  border-radius: ${themeCssVariables.border.radius.md};
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow: hidden;
  pointer-events: ${({ $isEditMode }) => ($isEditMode ? 'none' : 'auto')};
  position: relative;
  width: 100%;
`;

const StyledIframe = styled.iframe<{ $isEditMode: boolean }>`
  border: none;
  flex: 1;
  height: 100%;
  pointer-events: ${({ $isEditMode }) => ($isEditMode ? 'none' : 'auto')};
  width: 100%;
`;

const StyledLoadingContainer = styled.div`
  background: ${themeCssVariables.background.primary};
  bottom: 0;
  left: 0;
  padding-left: ${themeCssVariables.spacing[2]};
  padding-top: ${themeCssVariables.spacing[2]};
  pointer-events: none;
  position: absolute;
  right: 0;
  top: 0;
  z-index: 1;
`;

const StyledErrorContainer = styled.div`
  align-items: center;
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  padding: ${themeCssVariables.spacing[4]};
  text-align: center;
`;

export type IframeWidgetProps = {
  widget: PageLayoutWidget;
};

export const IframeWidget = ({ widget }: IframeWidgetProps) => {
  const isPageLayoutInEditMode = useIsPageLayoutInEditMode();

  const configuration = widget.configuration;

  if (!isDefined(configuration) || !('url' in configuration)) {
    throw new Error(`Invalid configuration for widget ${widget.id}`);
  }

  const url = configuration.url;
  const title = widget.title;

  const [isLoading, setIsLoading] = useState(true);
  const [hasError, setHasError] = useState(false);
  const { objectRecordId } = useParams();

  const handleIframeLoad = () => {
    setIsLoading(false);
  };

  const handleIframeError = () => {
    setIsLoading(false);
    setHasError(true);
  };

  // Прокидываем id текущей записи в URL iframe (?recordId=...), чтобы встроенное
  // приложение (напр. чат сделки) знало, какая запись открыта. Форк ru-translations.
  const urlWithRecord =
    isDefined(url) && isDefined(objectRecordId)
      ? `${url}${url.includes('?') ? '&' : '?'}recordId=${objectRecordId}`
      : url;

  const safeUrl = isDefined(urlWithRecord) ? getSafeUrl(urlWithRecord) : undefined;
  const isHttpUrl = isDefined(safeUrl) && /^https?:\/\//i.test(safeUrl);

  if (hasError || !isHttpUrl) {
    return (
      <StyledContainer $isEditMode={isPageLayoutInEditMode}>
        <StyledErrorContainer>
          <PageLayoutWidgetNoDataDisplay />
        </StyledErrorContainer>
      </StyledContainer>
    );
  }

  return (
    <StyledContainer $isEditMode={isPageLayoutInEditMode}>
      {isLoading && (
        <StyledLoadingContainer>
          <WidgetSkeletonLoader />
        </StyledLoadingContainer>
      )}
      <StyledIframe
        $isEditMode={isPageLayoutInEditMode}
        src={safeUrl}
        title={title}
        onLoad={handleIframeLoad}
        onError={handleIframeError}
        sandbox="allow-scripts allow-forms allow-popups allow-same-origin"
        allow="encrypted-media"
        allowFullScreen
      />
    </StyledContainer>
  );
};
